// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_source_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFoodSourceItemCollection on Isar {
  IsarCollection<FoodSourceItem> get foodSourceItems => this.collection();
}

const FoodSourceItemSchema = CollectionSchema(
  name: r'FoodSourceItem',
  id: 4271283435523302792,
  properties: {
    r'category': PropertySchema(
      id: 0,
      name: r'category',
      type: IsarType.string,
    ),
    r'defaultPortionGrams': PropertySchema(
      id: 1,
      name: r'defaultPortionGrams',
      type: IsarType.double,
    ),
    r'defaultPortionLabel': PropertySchema(
      id: 2,
      name: r'defaultPortionLabel',
      type: IsarType.string,
    ),
    r'energy': PropertySchema(
      id: 3,
      name: r'energy',
      type: IsarType.double,
    ),
    r'foodId': PropertySchema(
      id: 4,
      name: r'foodId',
      type: IsarType.string,
    ),
    r'foodState': PropertySchema(
      id: 5,
      name: r'foodState',
      type: IsarType.string,
    ),
    r'isFavorite': PropertySchema(
      id: 6,
      name: r'isFavorite',
      type: IsarType.bool,
    ),
    r'isTracked': PropertySchema(
      id: 7,
      name: r'isTracked',
      type: IsarType.bool,
    ),
    r'isVisibleOnApp': PropertySchema(
      id: 8,
      name: r'isVisibleOnApp',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 9,
      name: r'name',
      type: IsarType.string,
    ),
    r'nutrients': PropertySchema(
      id: 10,
      name: r'nutrients',
      type: IsarType.objectList,
      target: r'FoodNutrientValue',
    ),
    r'plannedDailyGrams': PropertySchema(
      id: 11,
      name: r'plannedDailyGrams',
      type: IsarType.double,
    ),
    r'plannedWeeklyGrams': PropertySchema(
      id: 12,
      name: r'plannedWeeklyGrams',
      type: IsarType.double,
    ),
    r'proteinIndex': PropertySchema(
      id: 13,
      name: r'proteinIndex',
      type: IsarType.long,
    ),
    r'title': PropertySchema(
      id: 14,
      name: r'title',
      type: IsarType.string,
    ),
    r'trackingFrequencyOverride': PropertySchema(
      id: 15,
      name: r'trackingFrequencyOverride',
      type: IsarType.string,
      enumMap: _FoodSourceItemtrackingFrequencyOverrideEnumValueMap,
    )
  },
  estimateSize: _foodSourceItemEstimateSize,
  serialize: _foodSourceItemSerialize,
  deserialize: _foodSourceItemDeserialize,
  deserializeProp: _foodSourceItemDeserializeProp,
  idName: r'id',
  indexes: {
    r'foodId': IndexSchema(
      id: 6823679418906861405,
      name: r'foodId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'foodId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'title': IndexSchema(
      id: -7636685945352118059,
      name: r'title',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'title',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'category': IndexSchema(
      id: -7560358558326323820,
      name: r'category',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'category',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'isVisibleOnApp': IndexSchema(
      id: -886209233986857688,
      name: r'isVisibleOnApp',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isVisibleOnApp',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isTracked': IndexSchema(
      id: 4497362699463139891,
      name: r'isTracked',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isTracked',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isFavorite': IndexSchema(
      id: 5742774614603939776,
      name: r'isFavorite',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isFavorite',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'FoodNutrientValue': FoodNutrientValueSchema},
  getId: _foodSourceItemGetId,
  getLinks: _foodSourceItemGetLinks,
  attach: _foodSourceItemAttach,
  version: '3.1.0+1',
);

int _foodSourceItemEstimateSize(
  FoodSourceItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.category.length * 3;
  {
    final value = object.defaultPortionLabel;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.foodId.length * 3;
  {
    final value = object.foodState;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.nutrients.length * 3;
  {
    final offsets = allOffsets[FoodNutrientValue]!;
    for (var i = 0; i < object.nutrients.length; i++) {
      final value = object.nutrients[i];
      bytesCount +=
          FoodNutrientValueSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.title.length * 3;
  {
    final value = object.trackingFrequencyOverride;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  return bytesCount;
}

void _foodSourceItemSerialize(
  FoodSourceItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.category);
  writer.writeDouble(offsets[1], object.defaultPortionGrams);
  writer.writeString(offsets[2], object.defaultPortionLabel);
  writer.writeDouble(offsets[3], object.energy);
  writer.writeString(offsets[4], object.foodId);
  writer.writeString(offsets[5], object.foodState);
  writer.writeBool(offsets[6], object.isFavorite);
  writer.writeBool(offsets[7], object.isTracked);
  writer.writeBool(offsets[8], object.isVisibleOnApp);
  writer.writeString(offsets[9], object.name);
  writer.writeObjectList<FoodNutrientValue>(
    offsets[10],
    allOffsets,
    FoodNutrientValueSchema.serialize,
    object.nutrients,
  );
  writer.writeDouble(offsets[11], object.plannedDailyGrams);
  writer.writeDouble(offsets[12], object.plannedWeeklyGrams);
  writer.writeLong(offsets[13], object.proteinIndex);
  writer.writeString(offsets[14], object.title);
  writer.writeString(offsets[15], object.trackingFrequencyOverride?.name);
}

FoodSourceItem _foodSourceItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FoodSourceItem();
  object.category = reader.readString(offsets[0]);
  object.defaultPortionGrams = reader.readDouble(offsets[1]);
  object.defaultPortionLabel = reader.readStringOrNull(offsets[2]);
  object.energy = reader.readDouble(offsets[3]);
  object.foodId = reader.readString(offsets[4]);
  object.foodState = reader.readStringOrNull(offsets[5]);
  object.id = id;
  object.isFavorite = reader.readBool(offsets[6]);
  object.isTracked = reader.readBool(offsets[7]);
  object.isVisibleOnApp = reader.readBool(offsets[8]);
  object.name = reader.readString(offsets[9]);
  object.nutrients = reader.readObjectList<FoodNutrientValue>(
        offsets[10],
        FoodNutrientValueSchema.deserialize,
        allOffsets,
        FoodNutrientValue(),
      ) ??
      [];
  object.plannedDailyGrams = reader.readDouble(offsets[11]);
  object.proteinIndex = reader.readLong(offsets[13]);
  object.title = reader.readString(offsets[14]);
  object.trackingFrequencyOverride =
      _FoodSourceItemtrackingFrequencyOverrideValueEnumMap[
          reader.readStringOrNull(offsets[15])];
  return object;
}

P _foodSourceItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readObjectList<FoodNutrientValue>(
            offset,
            FoodNutrientValueSchema.deserialize,
            allOffsets,
            FoodNutrientValue(),
          ) ??
          []) as P;
    case 11:
      return (reader.readDouble(offset)) as P;
    case 12:
      return (reader.readDouble(offset)) as P;
    case 13:
      return (reader.readLong(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (_FoodSourceItemtrackingFrequencyOverrideValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _FoodSourceItemtrackingFrequencyOverrideEnumValueMap = {
  r'daily': r'daily',
  r'weekly': r'weekly',
};
const _FoodSourceItemtrackingFrequencyOverrideValueEnumMap = {
  r'daily': TrackingFrequency.daily,
  r'weekly': TrackingFrequency.weekly,
};

Id _foodSourceItemGetId(FoodSourceItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _foodSourceItemGetLinks(FoodSourceItem object) {
  return [];
}

void _foodSourceItemAttach(
    IsarCollection<dynamic> col, Id id, FoodSourceItem object) {
  object.id = id;
}

extension FoodSourceItemByIndex on IsarCollection<FoodSourceItem> {
  Future<FoodSourceItem?> getByFoodId(String foodId) {
    return getByIndex(r'foodId', [foodId]);
  }

  FoodSourceItem? getByFoodIdSync(String foodId) {
    return getByIndexSync(r'foodId', [foodId]);
  }

  Future<bool> deleteByFoodId(String foodId) {
    return deleteByIndex(r'foodId', [foodId]);
  }

  bool deleteByFoodIdSync(String foodId) {
    return deleteByIndexSync(r'foodId', [foodId]);
  }

  Future<List<FoodSourceItem?>> getAllByFoodId(List<String> foodIdValues) {
    final values = foodIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'foodId', values);
  }

  List<FoodSourceItem?> getAllByFoodIdSync(List<String> foodIdValues) {
    final values = foodIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'foodId', values);
  }

  Future<int> deleteAllByFoodId(List<String> foodIdValues) {
    final values = foodIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'foodId', values);
  }

  int deleteAllByFoodIdSync(List<String> foodIdValues) {
    final values = foodIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'foodId', values);
  }

  Future<Id> putByFoodId(FoodSourceItem object) {
    return putByIndex(r'foodId', object);
  }

  Id putByFoodIdSync(FoodSourceItem object, {bool saveLinks = true}) {
    return putByIndexSync(r'foodId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByFoodId(List<FoodSourceItem> objects) {
    return putAllByIndex(r'foodId', objects);
  }

  List<Id> putAllByFoodIdSync(List<FoodSourceItem> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'foodId', objects, saveLinks: saveLinks);
  }
}

extension FoodSourceItemQueryWhereSort
    on QueryBuilder<FoodSourceItem, FoodSourceItem, QWhere> {
  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhere> anyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'name'),
      );
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhere> anyTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'title'),
      );
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhere>
      anyIsVisibleOnApp() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isVisibleOnApp'),
      );
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhere> anyIsTracked() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isTracked'),
      );
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhere> anyIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isFavorite'),
      );
    });
  }
}

extension FoodSourceItemQueryWhere
    on QueryBuilder<FoodSourceItem, FoodSourceItem, QWhereClause> {
  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause> foodIdEqualTo(
      String foodId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'foodId',
        value: [foodId],
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause>
      foodIdNotEqualTo(String foodId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'foodId',
              lower: [],
              upper: [foodId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'foodId',
              lower: [foodId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'foodId',
              lower: [foodId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'foodId',
              lower: [],
              upper: [foodId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause> nameEqualTo(
      String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause>
      nameNotEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause>
      nameGreaterThan(
    String name, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [name],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause> nameLessThan(
    String name, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [],
        upper: [name],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause> nameBetween(
    String lowerName,
    String upperName, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [lowerName],
        includeLower: includeLower,
        upper: [upperName],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause>
      nameStartsWith(String NamePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [NamePrefix],
        upper: ['$NamePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [''],
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'name',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'name',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'name',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'name',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause> titleEqualTo(
      String title) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'title',
        value: [title],
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause>
      titleNotEqualTo(String title) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [],
              upper: [title],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [title],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [title],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [],
              upper: [title],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause>
      titleGreaterThan(
    String title, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'title',
        lower: [title],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause> titleLessThan(
    String title, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'title',
        lower: [],
        upper: [title],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause> titleBetween(
    String lowerTitle,
    String upperTitle, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'title',
        lower: [lowerTitle],
        includeLower: includeLower,
        upper: [upperTitle],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause>
      titleStartsWith(String TitlePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'title',
        lower: [TitlePrefix],
        upper: ['$TitlePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'title',
        value: [''],
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'title',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'title',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'title',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'title',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause>
      categoryEqualTo(String category) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'category',
        value: [category],
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause>
      categoryNotEqualTo(String category) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'category',
              lower: [],
              upper: [category],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'category',
              lower: [category],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'category',
              lower: [category],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'category',
              lower: [],
              upper: [category],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause>
      isVisibleOnAppEqualTo(bool isVisibleOnApp) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isVisibleOnApp',
        value: [isVisibleOnApp],
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause>
      isVisibleOnAppNotEqualTo(bool isVisibleOnApp) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isVisibleOnApp',
              lower: [],
              upper: [isVisibleOnApp],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isVisibleOnApp',
              lower: [isVisibleOnApp],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isVisibleOnApp',
              lower: [isVisibleOnApp],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isVisibleOnApp',
              lower: [],
              upper: [isVisibleOnApp],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause>
      isTrackedEqualTo(bool isTracked) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isTracked',
        value: [isTracked],
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause>
      isTrackedNotEqualTo(bool isTracked) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isTracked',
              lower: [],
              upper: [isTracked],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isTracked',
              lower: [isTracked],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isTracked',
              lower: [isTracked],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isTracked',
              lower: [],
              upper: [isTracked],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause>
      isFavoriteEqualTo(bool isFavorite) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isFavorite',
        value: [isFavorite],
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterWhereClause>
      isFavoriteNotEqualTo(bool isFavorite) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isFavorite',
              lower: [],
              upper: [isFavorite],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isFavorite',
              lower: [isFavorite],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isFavorite',
              lower: [isFavorite],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isFavorite',
              lower: [],
              upper: [isFavorite],
              includeUpper: false,
            ));
      }
    });
  }
}

extension FoodSourceItemQueryFilter
    on QueryBuilder<FoodSourceItem, FoodSourceItem, QFilterCondition> {
  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      categoryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      categoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      categoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      categoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      defaultPortionGramsEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultPortionGrams',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      defaultPortionGramsGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'defaultPortionGrams',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      defaultPortionGramsLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'defaultPortionGrams',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      defaultPortionGramsBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'defaultPortionGrams',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      defaultPortionLabelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'defaultPortionLabel',
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      defaultPortionLabelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'defaultPortionLabel',
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      defaultPortionLabelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultPortionLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      defaultPortionLabelGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'defaultPortionLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      defaultPortionLabelLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'defaultPortionLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      defaultPortionLabelBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'defaultPortionLabel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      defaultPortionLabelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'defaultPortionLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      defaultPortionLabelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'defaultPortionLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      defaultPortionLabelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'defaultPortionLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      defaultPortionLabelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'defaultPortionLabel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      defaultPortionLabelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultPortionLabel',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      defaultPortionLabelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'defaultPortionLabel',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      energyEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'energy',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      energyGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'energy',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      energyLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'energy',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      energyBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'energy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      foodIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foodId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      foodIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'foodId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      foodIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'foodId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      foodIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'foodId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      foodIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'foodId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      foodIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'foodId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      foodIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'foodId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      foodIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'foodId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      foodIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foodId',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      foodIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'foodId',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      foodStateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'foodState',
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      foodStateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'foodState',
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      foodStateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foodState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      foodStateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'foodState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      foodStateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'foodState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      foodStateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'foodState',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      foodStateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'foodState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      foodStateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'foodState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      foodStateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'foodState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      foodStateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'foodState',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      foodStateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foodState',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      foodStateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'foodState',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      isFavoriteEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFavorite',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      isTrackedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isTracked',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      isVisibleOnAppEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isVisibleOnApp',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      nutrientsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nutrients',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      nutrientsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nutrients',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      nutrientsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nutrients',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      nutrientsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nutrients',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      nutrientsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nutrients',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      nutrientsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nutrients',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      plannedDailyGramsEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plannedDailyGrams',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      plannedDailyGramsGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'plannedDailyGrams',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      plannedDailyGramsLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'plannedDailyGrams',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      plannedDailyGramsBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'plannedDailyGrams',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      plannedWeeklyGramsEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plannedWeeklyGrams',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      plannedWeeklyGramsGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'plannedWeeklyGrams',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      plannedWeeklyGramsLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'plannedWeeklyGrams',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      plannedWeeklyGramsBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'plannedWeeklyGrams',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      proteinIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proteinIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      proteinIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'proteinIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      proteinIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'proteinIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      proteinIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'proteinIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      trackingFrequencyOverrideIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'trackingFrequencyOverride',
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      trackingFrequencyOverrideIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'trackingFrequencyOverride',
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      trackingFrequencyOverrideEqualTo(
    TrackingFrequency? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackingFrequencyOverride',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      trackingFrequencyOverrideGreaterThan(
    TrackingFrequency? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'trackingFrequencyOverride',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      trackingFrequencyOverrideLessThan(
    TrackingFrequency? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'trackingFrequencyOverride',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      trackingFrequencyOverrideBetween(
    TrackingFrequency? lower,
    TrackingFrequency? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'trackingFrequencyOverride',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      trackingFrequencyOverrideStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'trackingFrequencyOverride',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      trackingFrequencyOverrideEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'trackingFrequencyOverride',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      trackingFrequencyOverrideContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'trackingFrequencyOverride',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      trackingFrequencyOverrideMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'trackingFrequencyOverride',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      trackingFrequencyOverrideIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackingFrequencyOverride',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      trackingFrequencyOverrideIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trackingFrequencyOverride',
        value: '',
      ));
    });
  }
}

extension FoodSourceItemQueryObject
    on QueryBuilder<FoodSourceItem, FoodSourceItem, QFilterCondition> {
  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterFilterCondition>
      nutrientsElement(FilterQuery<FoodNutrientValue> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'nutrients');
    });
  }
}

extension FoodSourceItemQueryLinks
    on QueryBuilder<FoodSourceItem, FoodSourceItem, QFilterCondition> {}

extension FoodSourceItemQuerySortBy
    on QueryBuilder<FoodSourceItem, FoodSourceItem, QSortBy> {
  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      sortByDefaultPortionGrams() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultPortionGrams', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      sortByDefaultPortionGramsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultPortionGrams', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      sortByDefaultPortionLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultPortionLabel', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      sortByDefaultPortionLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultPortionLabel', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy> sortByEnergy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energy', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      sortByEnergyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energy', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy> sortByFoodId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodId', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      sortByFoodIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodId', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy> sortByFoodState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodState', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      sortByFoodStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodState', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      sortByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      sortByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy> sortByIsTracked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTracked', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      sortByIsTrackedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTracked', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      sortByIsVisibleOnApp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVisibleOnApp', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      sortByIsVisibleOnAppDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVisibleOnApp', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      sortByPlannedDailyGrams() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plannedDailyGrams', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      sortByPlannedDailyGramsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plannedDailyGrams', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      sortByPlannedWeeklyGrams() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plannedWeeklyGrams', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      sortByPlannedWeeklyGramsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plannedWeeklyGrams', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      sortByProteinIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinIndex', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      sortByProteinIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinIndex', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      sortByTrackingFrequencyOverride() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackingFrequencyOverride', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      sortByTrackingFrequencyOverrideDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackingFrequencyOverride', Sort.desc);
    });
  }
}

extension FoodSourceItemQuerySortThenBy
    on QueryBuilder<FoodSourceItem, FoodSourceItem, QSortThenBy> {
  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      thenByDefaultPortionGrams() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultPortionGrams', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      thenByDefaultPortionGramsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultPortionGrams', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      thenByDefaultPortionLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultPortionLabel', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      thenByDefaultPortionLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultPortionLabel', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy> thenByEnergy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energy', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      thenByEnergyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energy', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy> thenByFoodId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodId', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      thenByFoodIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodId', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy> thenByFoodState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodState', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      thenByFoodStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foodState', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      thenByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      thenByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy> thenByIsTracked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTracked', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      thenByIsTrackedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTracked', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      thenByIsVisibleOnApp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVisibleOnApp', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      thenByIsVisibleOnAppDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVisibleOnApp', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      thenByPlannedDailyGrams() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plannedDailyGrams', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      thenByPlannedDailyGramsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plannedDailyGrams', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      thenByPlannedWeeklyGrams() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plannedWeeklyGrams', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      thenByPlannedWeeklyGramsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plannedWeeklyGrams', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      thenByProteinIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinIndex', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      thenByProteinIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proteinIndex', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      thenByTrackingFrequencyOverride() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackingFrequencyOverride', Sort.asc);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QAfterSortBy>
      thenByTrackingFrequencyOverrideDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackingFrequencyOverride', Sort.desc);
    });
  }
}

extension FoodSourceItemQueryWhereDistinct
    on QueryBuilder<FoodSourceItem, FoodSourceItem, QDistinct> {
  QueryBuilder<FoodSourceItem, FoodSourceItem, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QDistinct>
      distinctByDefaultPortionGrams() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'defaultPortionGrams');
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QDistinct>
      distinctByDefaultPortionLabel({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'defaultPortionLabel',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QDistinct> distinctByEnergy() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'energy');
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QDistinct> distinctByFoodId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'foodId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QDistinct> distinctByFoodState(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'foodState', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QDistinct>
      distinctByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFavorite');
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QDistinct>
      distinctByIsTracked() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isTracked');
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QDistinct>
      distinctByIsVisibleOnApp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isVisibleOnApp');
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QDistinct>
      distinctByPlannedDailyGrams() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'plannedDailyGrams');
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QDistinct>
      distinctByPlannedWeeklyGrams() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'plannedWeeklyGrams');
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QDistinct>
      distinctByProteinIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proteinIndex');
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FoodSourceItem, FoodSourceItem, QDistinct>
      distinctByTrackingFrequencyOverride({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trackingFrequencyOverride',
          caseSensitive: caseSensitive);
    });
  }
}

extension FoodSourceItemQueryProperty
    on QueryBuilder<FoodSourceItem, FoodSourceItem, QQueryProperty> {
  QueryBuilder<FoodSourceItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FoodSourceItem, String, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<FoodSourceItem, double, QQueryOperations>
      defaultPortionGramsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'defaultPortionGrams');
    });
  }

  QueryBuilder<FoodSourceItem, String?, QQueryOperations>
      defaultPortionLabelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'defaultPortionLabel');
    });
  }

  QueryBuilder<FoodSourceItem, double, QQueryOperations> energyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'energy');
    });
  }

  QueryBuilder<FoodSourceItem, String, QQueryOperations> foodIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'foodId');
    });
  }

  QueryBuilder<FoodSourceItem, String?, QQueryOperations> foodStateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'foodState');
    });
  }

  QueryBuilder<FoodSourceItem, bool, QQueryOperations> isFavoriteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFavorite');
    });
  }

  QueryBuilder<FoodSourceItem, bool, QQueryOperations> isTrackedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isTracked');
    });
  }

  QueryBuilder<FoodSourceItem, bool, QQueryOperations>
      isVisibleOnAppProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isVisibleOnApp');
    });
  }

  QueryBuilder<FoodSourceItem, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<FoodSourceItem, List<FoodNutrientValue>, QQueryOperations>
      nutrientsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nutrients');
    });
  }

  QueryBuilder<FoodSourceItem, double, QQueryOperations>
      plannedDailyGramsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'plannedDailyGrams');
    });
  }

  QueryBuilder<FoodSourceItem, double, QQueryOperations>
      plannedWeeklyGramsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'plannedWeeklyGrams');
    });
  }

  QueryBuilder<FoodSourceItem, int, QQueryOperations> proteinIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proteinIndex');
    });
  }

  QueryBuilder<FoodSourceItem, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<FoodSourceItem, TrackingFrequency?, QQueryOperations>
      trackingFrequencyOverrideProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trackingFrequencyOverride');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const FoodNutrientValueSchema = Schema(
  name: r'FoodNutrientValue',
  id: 4454031014700051683,
  properties: {
    r'amountPer100g': PropertySchema(
      id: 0,
      name: r'amountPer100g',
      type: IsarType.double,
    ),
    r'nutrientKey': PropertySchema(
      id: 1,
      name: r'nutrientKey',
      type: IsarType.string,
    )
  },
  estimateSize: _foodNutrientValueEstimateSize,
  serialize: _foodNutrientValueSerialize,
  deserialize: _foodNutrientValueDeserialize,
  deserializeProp: _foodNutrientValueDeserializeProp,
);

int _foodNutrientValueEstimateSize(
  FoodNutrientValue object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nutrientKey.length * 3;
  return bytesCount;
}

void _foodNutrientValueSerialize(
  FoodNutrientValue object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.amountPer100g);
  writer.writeString(offsets[1], object.nutrientKey);
}

FoodNutrientValue _foodNutrientValueDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FoodNutrientValue();
  object.amountPer100g = reader.readDouble(offsets[0]);
  object.nutrientKey = reader.readString(offsets[1]);
  return object;
}

P _foodNutrientValueDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension FoodNutrientValueQueryFilter
    on QueryBuilder<FoodNutrientValue, FoodNutrientValue, QFilterCondition> {
  QueryBuilder<FoodNutrientValue, FoodNutrientValue, QAfterFilterCondition>
      amountPer100gEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amountPer100g',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodNutrientValue, FoodNutrientValue, QAfterFilterCondition>
      amountPer100gGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amountPer100g',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodNutrientValue, FoodNutrientValue, QAfterFilterCondition>
      amountPer100gLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amountPer100g',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodNutrientValue, FoodNutrientValue, QAfterFilterCondition>
      amountPer100gBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amountPer100g',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<FoodNutrientValue, FoodNutrientValue, QAfterFilterCondition>
      nutrientKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nutrientKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodNutrientValue, FoodNutrientValue, QAfterFilterCondition>
      nutrientKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nutrientKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodNutrientValue, FoodNutrientValue, QAfterFilterCondition>
      nutrientKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nutrientKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodNutrientValue, FoodNutrientValue, QAfterFilterCondition>
      nutrientKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nutrientKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodNutrientValue, FoodNutrientValue, QAfterFilterCondition>
      nutrientKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nutrientKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodNutrientValue, FoodNutrientValue, QAfterFilterCondition>
      nutrientKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nutrientKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodNutrientValue, FoodNutrientValue, QAfterFilterCondition>
      nutrientKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nutrientKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodNutrientValue, FoodNutrientValue, QAfterFilterCondition>
      nutrientKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nutrientKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FoodNutrientValue, FoodNutrientValue, QAfterFilterCondition>
      nutrientKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nutrientKey',
        value: '',
      ));
    });
  }

  QueryBuilder<FoodNutrientValue, FoodNutrientValue, QAfterFilterCondition>
      nutrientKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nutrientKey',
        value: '',
      ));
    });
  }
}

extension FoodNutrientValueQueryObject
    on QueryBuilder<FoodNutrientValue, FoodNutrientValue, QFilterCondition> {}
