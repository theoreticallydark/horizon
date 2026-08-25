import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:horizon/data/models/user_profile.dart';
import 'package:horizon/data/models/nutrient_info.dart';
import 'package:horizon/data/models/food_source_item.dart';
import 'package:horizon/data/models/daily_record.dart';
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
        DailyRecordSchema,
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
          ..rdaOrAi = (valMap['rda_or_ai'] as num?)?.toDouble()
          ..ul = (valMap['ul'] as num?)?.toDouble();
        nutrientEntitiesToSave.add(entity);
      } else {
        bool changed = false;
        if (existing.shortKey != shortKeyVal && shortKeyVal != null) {
          existing.shortKey = shortKeyVal;
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

    // If foods are already populated, skip re-parsing foods for instant startup
    if (foodCount > 0) return;


    // 2. Prepare FoodSourceItem items
    final List<FoodSourceItem> foodEntities = [];
    for (final item in foodsList) {
      final f = item as Map<String, dynamic>;
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
        ..foodId = f['food_id']?.toString() ?? ''
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
      // Batch insert foods in chunks of 500 for optimal performance
      const chunkSize = 500;
      for (var i = 0; i < foodEntities.length; i += chunkSize) {
        final end = (i + chunkSize < foodEntities.length)
            ? i + chunkSize
            : foodEntities.length;
        await isar.foodSourceItems.putAll(foodEntities.sublist(i, end));
      }
    });
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
