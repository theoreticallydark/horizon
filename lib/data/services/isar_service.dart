import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:horizon/data/models/user_profile.dart';
import 'package:horizon/data/models/nutrient_info.dart';
import 'package:horizon/data/models/food_source_item.dart';
import 'package:horizon/data/models/track_record.dart';
import 'package:horizon/data/utils/demographic_lookup.dart';

class IsarService {
  static final IsarService instance = IsarService._internal();
  IsarService._internal();

  Isar? _isar;

  Isar get isar {
    if (_isar == null) {
      throw StateError('Isar has not been initialized. Call init() first.');
    }
    return _isar!;
  }

  /// Initialize Isar and perform initial database seeding if necessary.
  Future<void> init() async {
    if (_isar != null && _isar!.isOpen) return;

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [
        UserProfileSchema,
        NutrientInfoSchema,
        FoodSourceItemSchema,
        TrackRecordDailySchema,
        TrackRecordWeeklySchema,
      ],
      directory: dir.path,
      name: 'horizon_db',
    );

    await _seedDatabaseIfRequired();
  }

  /// Seeds or updates the DRI nutrients and Food sources from json
  Future<void> _seedDatabaseIfRequired() async {
    final foodCount = await isar.foodSourceItems.count();
    
    // Always ensure a default UserProfile exists
    var profile = await isar.userProfiles.get(1);
    if (profile == null) {
      profile = UserProfile()
        ..id = 1
        ..age = 25
        ..sex = 'male'
        ..isPregnant = false
        ..isLactating = false
        ..strictness = 0.9;
      await isar.writeTxn(() async {
        await isar.userProfiles.put(profile!);
      });
    }

    // Load JSON from bundle
    final jsonString = await rootBundle.loadString('sources/dri_and_foods.json');
    final Map<String, dynamic> root = jsonDecode(jsonString);

    final sources = root['sources'] as Map<String, dynamic>;
    final driDataList = sources['dri']['data'] as List<dynamic>;
    final foodsList = sources['foods']['foods'] as List<dynamic>;

    // Find demographic entry matching default profile
    final demoMatch = DemographicLookup.findDemographicMatch(
      driDataList: driDataList,
      ageInYears: profile.age,
      sex: profile.sex,
      isPregnant: profile.isPregnant,
      isLactating: profile.isLactating,
    );

    final driNutrients = demoMatch != null
        ? demoMatch['nutrients'] as Map<String, dynamic>
        : <String, dynamic>{};

    // Primary visible nutrients on app
    const primaryVisibleNutrients = {
      'energy',
      'total_protein',
      'vitamin_c',
      'collagen',
      'total_fiber',
      'magnesium',
      'calcium',
      'potassium',
      'iodine',
      'folate',
      'linoleic_acid_omega_6',
      'creatine',
      'vitamin_a',
      'vitamin_e',
      'vitamin_b12',
      'selenium',
      'zinc',
      'iron',
      'vitamin_k',
      'vitamin_d',
      'alpha_linolenic_acid_omega_3',
      'omega_3_epa_dha',
    };

    // 7 specific daily nutrients in database
    const dailyNutrients = {
      'vitamin_c', // Vit C
      'collagen',  // Coll.
      'total_fiber', // Fiber
      'magnesium', // Mg
      'calcium',   // Ca
      'potassium', // K
      'creatine',  // Creat.
    };

    // 1. Sync / Add / Update NutrientInfo items
    final List<NutrientInfo> nutrientEntitiesToSave = [];
    for (final entry in driNutrients.entries) {
      final key = entry.key;
      final valMap = entry.value as Map<String, dynamic>;
      final shortKeyVal = valMap['key']?.toString();
      final isVisible = primaryVisibleNutrients.contains(key);
      final frequency = dailyNutrients.contains(key)
          ? TrackingFrequency.daily
          : TrackingFrequency.weekly;
      final existing = await isar.nutrientInfos.getByNutrientKey(key);

      final rawTarget = (valMap['rda_or_ai'] as num?)?.toDouble() ??
          (valMap['app_default_target'] as num?)?.toDouble();

      if (existing == null) {
        final entity = NutrientInfo()
          ..nutrientKey = key
          ..shortKey = shortKeyVal
          ..displayName = _formatDisplayName(key)
          ..unit = valMap['unit']?.toString() ?? ''
          ..isVisibleOnApp = isVisible
          ..isTracked = isVisible
          ..frequency = frequency
          ..ear = (valMap['ear'] as num?)?.toDouble()
          ..rdaOrAi = rawTarget
          ..ul = (valMap['ul'] as num?)?.toDouble();
        nutrientEntitiesToSave.add(entity);
      } else {
        bool changed = false;
        if (existing.shortKey != shortKeyVal && shortKeyVal != null) {
          existing.shortKey = shortKeyVal;
          changed = true;
        }
        if (existing.rdaOrAi != rawTarget && rawTarget != null) {
          existing.rdaOrAi = rawTarget;
          changed = true;
        }
        if (existing.isVisibleOnApp != isVisible) {
          existing.isVisibleOnApp = isVisible;
          if (!isVisible) {
            existing.isTracked = false;
          }
          changed = true;
        }
        if (existing.frequency != frequency) {
          existing.frequency = frequency;
          changed = true;
        }
        if (changed) {
          nutrientEntitiesToSave.add(existing);
        }
      }
    }

    if (nutrientEntitiesToSave.isNotEmpty) {
      await isar.writeTxn(() async {
        await isar.nutrientInfos.putAll(nutrientEntitiesToSave);
      });
    }

    // 2. Prepare FoodSourceItem items (insert if empty or refresh existing)
    if (foodCount == 0) {
      final List<FoodSourceItem> foodEntities = [];
      for (final item in foodsList) {
        final f = item as Map<String, dynamic>;
        final fid = f['food_id']?.toString() ?? '';
        final defaultPortion = f['default_portion'] as Map<String, dynamic>?;
        final grams = (defaultPortion?['grams'] as num?)?.toDouble() ?? 100.0;
        final label = defaultPortion?['label']?.toString() ?? '100g';

        final nutrientMap = f['nutrients'] as Map<String, dynamic>? ?? {};
        final List<FoodNutrientValue> nutrientValues = [];
        nutrientMap.forEach((nKey, nVal) {
          final amount = (nVal as num?)?.toDouble() ?? 0.0;
          nutrientValues.add(
            FoodNutrientValue()
              ..nutrientKey = nKey
              ..amountPer100g = amount,
          );
        });

        final foodItem = FoodSourceItem()
          ..foodId = fid
          ..name = f['name']?.toString() ?? ''
          ..title = f['title']?.toString() ?? f['name']?.toString() ?? ''
          ..category = f['category']?.toString() ?? 'Other'
          ..foodState = f['food_state']?.toString()
          ..isVisibleOnApp = true
          ..isTracked = false
          ..isFavorite = false
          ..defaultPortionLabel = label
          ..defaultPortionGrams = grams
          ..plannedDailyGrams = grams
          ..energy = (f['energy'] as num?)?.toDouble() ?? 0.0
          ..proteinIndex = (f['protein_index'] as num?)?.toInt() ?? 0
          ..nutrients = nutrientValues;

        foodEntities.add(foodItem);
      }

      // Batch insert foods into Isar in chunks
      await isar.writeTxn(() async {
        const chunkSize = 500;
        for (var i = 0; i < foodEntities.length; i += chunkSize) {
          final end = (i + chunkSize < foodEntities.length)
              ? i + chunkSize
              : foodEntities.length;
          await isar.foodSourceItems.putAll(foodEntities.sublist(i, end));
        }
      });
    }
  }

  /// Demo helper: Populates the user's routine with a comprehensive set of foods covering all 20 nutrients 100%+
  Future<void> seedDemoRoutine() async {
    final profile = await isar.userProfiles.get(1) ?? UserProfile();
    final allNutrients = await isar.nutrientInfos.where().findAll();

    final Map<String, double> demoRoutineTargets = {
      'fdc_173044': 165.0,  // Guava (Vit C, Fiber, K)
      'fdc_170556': 100.0,  // Pumpkin Seeds (Mg, Zinc, K, Protein)
      'fdc_168593': 40.0,   // Sunflower Seeds (Vit E, Se, Om6)
      'fdc_2262075': 25.0,  // Flaxseed ground (ALA Omega-3, Fiber)
      'fdc_170567': 80.0,   // Almonds (Vit E, Ca, Mg)
      'fdc_171287': 200.0,  // Eggs (Protein, Vit D, B12, Se)
      'fdc_168462': 100.0,  // Spinach Raw (Vit K, Folate, Iron, Vit A)
      'fdc_172420': 80.0,   // Lentils Raw (Folate, Iron, Fiber, K)
      'fdc_170393': 120.0,  // Carrots Raw (Vit A / beta-carotene)
      'fdc_2259793': 200.0, // Yogurt (Calcium, Iodine, Protein)
      'fdc_173418': 50.0,   // Cheddar Cheese (Calcium, Protein)
      'fdc_747447': 150.0,  // Broccoli Raw (Vit C, Vit K, Folate)
      'fdc_170026': 200.0,  // Potatoes Raw (Potassium, Vit C, B6)
      'fdc_173944': 120.0,  // Banana (Potassium, Vit C, B6)
      'fdc_746775': 2.0,    // Iodized Table Salt (Iodine)
    };

    // Load updated JSON to ensure nutrients and metadata are refreshed
    final jsonString = await rootBundle.loadString('sources/dri_and_foods.json');
    final Map<String, dynamic> root = jsonDecode(jsonString);
    final foodsList = root['sources']['foods']['foods'] as List<dynamic>;
    final foodJsonMap = {for (var f in foodsList) (f as Map<String, dynamic>)['food_id']?.toString(): f};

    // Untrack all current foods first
    final allFoods = await isar.foodSourceItems.where().findAll();
    for (final f in allFoods) {
      f.isTracked = false;
      final jsonFood = foodJsonMap[f.foodId];
      if (jsonFood != null) {
        f.energy = (jsonFood['energy'] as num?)?.toDouble() ?? 0.0;
        f.proteinIndex = (jsonFood['protein_index'] as num?)?.toInt() ?? 0;
      }
    }
    if (allFoods.isNotEmpty) {
      await isar.writeTxn(() async {
        await isar.foodSourceItems.putAll(allFoods);
      });
    }

    final List<FoodSourceItem> updates = [];
    for (final entry in demoRoutineTargets.entries) {
      final fid = entry.key;
      final plannedGrams = entry.value;

      var item = await isar.foodSourceItems.getByFoodId(fid);
      final jsonFood = foodJsonMap[fid];

      if (jsonFood != null) {
        final nutrientMap = jsonFood['nutrients'] as Map<String, dynamic>? ?? {};
        final List<FoodNutrientValue> nutrientValues = [];
        nutrientMap.forEach((nKey, nVal) {
          final amount = (nVal as num?)?.toDouble() ?? 0.0;
          nutrientValues.add(
            FoodNutrientValue()
              ..nutrientKey = nKey
              ..amountPer100g = amount,
          );
        });

        item ??= FoodSourceItem()
          ..foodId = fid
          ..name = jsonFood['name']?.toString() ?? ''
          ..title = jsonFood['title']?.toString() ?? jsonFood['name']?.toString() ?? ''
          ..category = jsonFood['category']?.toString() ?? 'Other'
          ..foodState = jsonFood['food_state']?.toString()
          ..isVisibleOnApp = true
          ..defaultPortionGrams = plannedGrams;

        item.name = jsonFood['name']?.toString() ?? item.name;
        item.title = jsonFood['title']?.toString() ?? jsonFood['name']?.toString() ?? item.title;
        item.category = jsonFood['category']?.toString() ?? item.category;
        item.energy = (jsonFood['energy'] as num?)?.toDouble() ?? 0.0;
        item.proteinIndex = (jsonFood['protein_index'] as num?)?.toInt() ?? 0;
        item.nutrients = nutrientValues;
      }

      if (item != null) {
        item.isTracked = true;
        item.plannedDailyGrams = plannedGrams;
        item.frequency = item.calculateFrequency(profile: profile, allNutrients: allNutrients);
        updates.add(item);
      }
    }

    if (updates.isNotEmpty) {
      await isar.writeTxn(() async {
        await isar.foodSourceItems.putAll(updates);
      });
    }
  }

  /// Demo helper: Resets all foods in the database to isTracked = false
  Future<void> resetAllFoodsToUntracked() async {
    final trackedFoods = await isar.foodSourceItems.filter().isTrackedEqualTo(true).findAll();
    if (trackedFoods.isNotEmpty) {
      for (final f in trackedFoods) {
        f.isTracked = false;
      }
      await isar.writeTxn(() async {
        await isar.foodSourceItems.putAll(trackedFoods);
      });
    }
  }

  /// Returns all tracked nutrients excluding energy and total_protein for the NutrientMap
  Future<List<NutrientInfo>> getTrackedNutrientsForMap() async {
    final allTracked = await isar.nutrientInfos
        .filter()
        .isTrackedEqualTo(true)
        .findAll();

    return allTracked
        .where((n) => n.nutrientKey != 'energy' && n.nutrientKey != 'total_protein')
        .toList();
  }

  /// Watch stream of tracked nutrients excluding energy and total_protein for reactive NutrientMap
  Stream<List<NutrientInfo>> watchTrackedNutrientsForMap() {
    if (_isar == null) {
      return Stream.value([]);
    }
    return isar.nutrientInfos
        .filter()
        .isTrackedEqualTo(true)
        .watch(fireImmediately: true)
        .map((list) => list
            .where((n) => n.nutrientKey != 'energy' && n.nutrientKey != 'total_protein')
            .toList());
  }

  static String _formatDisplayName(String key) {
    return key
        .split('_')
        .map((w) => w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '')
        .join(' ');
  }
}
