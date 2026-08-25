// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrient_info.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetNutrientInfoCollection on Isar {
  IsarCollection<NutrientInfo> get nutrientInfos => this.collection();
}

const NutrientInfoSchema = CollectionSchema(
  name: r'NutrientInfo',
  id: 102047656033172783,
  properties: {
    r'category': PropertySchema(
      id: 0,
      name: r'category',
      type: IsarType.string,
    ),
    r'displayName': PropertySchema(
      id: 1,
      name: r'displayName',
      type: IsarType.string,
    ),
    r'ear': PropertySchema(
      id: 2,
      name: r'ear',
      type: IsarType.double,
    ),
    r'frequency': PropertySchema(
      id: 3,
      name: r'frequency',
      type: IsarType.string,
      enumMap: _NutrientInfofrequencyEnumValueMap,
    ),
    r'isTracked': PropertySchema(
      id: 4,
      name: r'isTracked',
      type: IsarType.bool,
    ),
    r'isVisibleOnApp': PropertySchema(
      id: 5,
      name: r'isVisibleOnApp',
      type: IsarType.bool,
    ),
    r'nutrientKey': PropertySchema(
      id: 6,
      name: r'nutrientKey',
      type: IsarType.string,
    ),
    r'rdaOrAi': PropertySchema(
      id: 7,
      name: r'rdaOrAi',
      type: IsarType.double,
    ),
    r'ul': PropertySchema(
      id: 8,
      name: r'ul',
      type: IsarType.double,
    ),
    r'unit': PropertySchema(
      id: 9,
      name: r'unit',
      type: IsarType.string,
    )
  },
  estimateSize: _nutrientInfoEstimateSize,
  serialize: _nutrientInfoSerialize,
  deserialize: _nutrientInfoDeserialize,
  deserializeProp: _nutrientInfoDeserializeProp,
  idName: r'id',
  indexes: {
    r'nutrientKey': IndexSchema(
      id: -1638203696805641499,
      name: r'nutrientKey',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'nutrientKey',
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
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _nutrientInfoGetId,
  getLinks: _nutrientInfoGetLinks,
  attach: _nutrientInfoAttach,
  version: '3.1.0+1',
);

int _nutrientInfoEstimateSize(
  NutrientInfo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.category;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.displayName.length * 3;
  bytesCount += 3 + object.frequency.name.length * 3;
  bytesCount += 3 + object.nutrientKey.length * 3;
  bytesCount += 3 + object.unit.length * 3;
  return bytesCount;
}

void _nutrientInfoSerialize(
  NutrientInfo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.category);
  writer.writeString(offsets[1], object.displayName);
  writer.writeDouble(offsets[2], object.ear);
  writer.writeString(offsets[3], object.frequency.name);
  writer.writeBool(offsets[4], object.isTracked);
  writer.writeBool(offsets[5], object.isVisibleOnApp);
  writer.writeString(offsets[6], object.nutrientKey);
  writer.writeDouble(offsets[7], object.rdaOrAi);
  writer.writeDouble(offsets[8], object.ul);
  writer.writeString(offsets[9], object.unit);
}

NutrientInfo _nutrientInfoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = NutrientInfo();
  object.category = reader.readStringOrNull(offsets[0]);
  object.displayName = reader.readString(offsets[1]);
  object.ear = reader.readDoubleOrNull(offsets[2]);
  object.frequency =
      _NutrientInfofrequencyValueEnumMap[reader.readStringOrNull(offsets[3])] ??
          TrackingFrequency.daily;
  object.id = id;
  object.isTracked = reader.readBool(offsets[4]);
  object.isVisibleOnApp = reader.readBool(offsets[5]);
  object.nutrientKey = reader.readString(offsets[6]);
  object.rdaOrAi = reader.readDoubleOrNull(offsets[7]);
  object.ul = reader.readDoubleOrNull(offsets[8]);
  object.unit = reader.readString(offsets[9]);
  return object;
}

P _nutrientInfoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (_NutrientInfofrequencyValueEnumMap[
              reader.readStringOrNull(offset)] ??
          TrackingFrequency.daily) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readDoubleOrNull(offset)) as P;
    case 8:
      return (reader.readDoubleOrNull(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _NutrientInfofrequencyEnumValueMap = {
  r'daily': r'daily',
  r'weekly': r'weekly',
};
const _NutrientInfofrequencyValueEnumMap = {
  r'daily': TrackingFrequency.daily,
  r'weekly': TrackingFrequency.weekly,
};

Id _nutrientInfoGetId(NutrientInfo object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _nutrientInfoGetLinks(NutrientInfo object) {
  return [];
}

void _nutrientInfoAttach(
    IsarCollection<dynamic> col, Id id, NutrientInfo object) {
  object.id = id;
}

extension NutrientInfoByIndex on IsarCollection<NutrientInfo> {
  Future<NutrientInfo?> getByNutrientKey(String nutrientKey) {
    return getByIndex(r'nutrientKey', [nutrientKey]);
  }

  NutrientInfo? getByNutrientKeySync(String nutrientKey) {
    return getByIndexSync(r'nutrientKey', [nutrientKey]);
  }

  Future<bool> deleteByNutrientKey(String nutrientKey) {
    return deleteByIndex(r'nutrientKey', [nutrientKey]);
  }

  bool deleteByNutrientKeySync(String nutrientKey) {
    return deleteByIndexSync(r'nutrientKey', [nutrientKey]);
  }

  Future<List<NutrientInfo?>> getAllByNutrientKey(
      List<String> nutrientKeyValues) {
    final values = nutrientKeyValues.map((e) => [e]).toList();
    return getAllByIndex(r'nutrientKey', values);
  }

  List<NutrientInfo?> getAllByNutrientKeySync(List<String> nutrientKeyValues) {
    final values = nutrientKeyValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'nutrientKey', values);
  }

  Future<int> deleteAllByNutrientKey(List<String> nutrientKeyValues) {
    final values = nutrientKeyValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'nutrientKey', values);
  }

  int deleteAllByNutrientKeySync(List<String> nutrientKeyValues) {
    final values = nutrientKeyValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'nutrientKey', values);
  }

  Future<Id> putByNutrientKey(NutrientInfo object) {
    return putByIndex(r'nutrientKey', object);
  }

  Id putByNutrientKeySync(NutrientInfo object, {bool saveLinks = true}) {
    return putByIndexSync(r'nutrientKey', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByNutrientKey(List<NutrientInfo> objects) {
    return putAllByIndex(r'nutrientKey', objects);
  }

  List<Id> putAllByNutrientKeySync(List<NutrientInfo> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'nutrientKey', objects, saveLinks: saveLinks);
  }
}

extension NutrientInfoQueryWhereSort
    on QueryBuilder<NutrientInfo, NutrientInfo, QWhere> {
  QueryBuilder<NutrientInfo, NutrientInfo, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterWhere> anyIsVisibleOnApp() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isVisibleOnApp'),
      );
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterWhere> anyIsTracked() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isTracked'),
      );
    });
  }
}

extension NutrientInfoQueryWhere
    on QueryBuilder<NutrientInfo, NutrientInfo, QWhereClause> {
  QueryBuilder<NutrientInfo, NutrientInfo, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterWhereClause> idBetween(
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

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterWhereClause>
      nutrientKeyEqualTo(String nutrientKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nutrientKey',
        value: [nutrientKey],
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterWhereClause>
      nutrientKeyNotEqualTo(String nutrientKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nutrientKey',
              lower: [],
              upper: [nutrientKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nutrientKey',
              lower: [nutrientKey],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nutrientKey',
              lower: [nutrientKey],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nutrientKey',
              lower: [],
              upper: [nutrientKey],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterWhereClause>
      isVisibleOnAppEqualTo(bool isVisibleOnApp) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isVisibleOnApp',
        value: [isVisibleOnApp],
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterWhereClause>
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

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterWhereClause> isTrackedEqualTo(
      bool isTracked) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isTracked',
        value: [isTracked],
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterWhereClause>
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
}

extension NutrientInfoQueryFilter
    on QueryBuilder<NutrientInfo, NutrientInfo, QFilterCondition> {
  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      categoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      categoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      categoryEqualTo(
    String? value, {
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

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      categoryGreaterThan(
    String? value, {
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

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      categoryLessThan(
    String? value, {
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

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      categoryBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
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

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
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

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      displayNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      displayNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      displayNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      displayNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'displayName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      displayNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      displayNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      displayNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      displayNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'displayName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      displayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      displayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition> earIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ear',
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      earIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ear',
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition> earEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ear',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      earGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ear',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition> earLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ear',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition> earBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ear',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      frequencyEqualTo(
    TrackingFrequency value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      frequencyGreaterThan(
    TrackingFrequency value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'frequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      frequencyLessThan(
    TrackingFrequency value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'frequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      frequencyBetween(
    TrackingFrequency lower,
    TrackingFrequency upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'frequency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      frequencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'frequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      frequencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'frequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      frequencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'frequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      frequencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'frequency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      frequencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frequency',
        value: '',
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      frequencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'frequency',
        value: '',
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition> idBetween(
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

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      isTrackedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isTracked',
        value: value,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      isVisibleOnAppEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isVisibleOnApp',
        value: value,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
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

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
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

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
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

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
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

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
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

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
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

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      nutrientKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nutrientKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      nutrientKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nutrientKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      nutrientKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nutrientKey',
        value: '',
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      nutrientKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nutrientKey',
        value: '',
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      rdaOrAiIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rdaOrAi',
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      rdaOrAiIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rdaOrAi',
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      rdaOrAiEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rdaOrAi',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      rdaOrAiGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rdaOrAi',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      rdaOrAiLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rdaOrAi',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      rdaOrAiBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rdaOrAi',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition> ulIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ul',
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      ulIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ul',
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition> ulEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ul',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition> ulGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ul',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition> ulLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ul',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition> ulBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ul',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition> unitEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      unitGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition> unitLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition> unitBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      unitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition> unitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition> unitContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition> unitMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'unit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      unitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: '',
      ));
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterFilterCondition>
      unitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'unit',
        value: '',
      ));
    });
  }
}

extension NutrientInfoQueryObject
    on QueryBuilder<NutrientInfo, NutrientInfo, QFilterCondition> {}

extension NutrientInfoQueryLinks
    on QueryBuilder<NutrientInfo, NutrientInfo, QFilterCondition> {}

extension NutrientInfoQuerySortBy
    on QueryBuilder<NutrientInfo, NutrientInfo, QSortBy> {
  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> sortByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy>
      sortByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> sortByEar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ear', Sort.asc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> sortByEarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ear', Sort.desc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> sortByFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.asc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> sortByFrequencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.desc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> sortByIsTracked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTracked', Sort.asc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> sortByIsTrackedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTracked', Sort.desc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy>
      sortByIsVisibleOnApp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVisibleOnApp', Sort.asc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy>
      sortByIsVisibleOnAppDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVisibleOnApp', Sort.desc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> sortByNutrientKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nutrientKey', Sort.asc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy>
      sortByNutrientKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nutrientKey', Sort.desc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> sortByRdaOrAi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rdaOrAi', Sort.asc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> sortByRdaOrAiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rdaOrAi', Sort.desc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> sortByUl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ul', Sort.asc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> sortByUlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ul', Sort.desc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> sortByUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.asc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> sortByUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.desc);
    });
  }
}

extension NutrientInfoQuerySortThenBy
    on QueryBuilder<NutrientInfo, NutrientInfo, QSortThenBy> {
  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> thenByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy>
      thenByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> thenByEar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ear', Sort.asc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> thenByEarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ear', Sort.desc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> thenByFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.asc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> thenByFrequencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.desc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> thenByIsTracked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTracked', Sort.asc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> thenByIsTrackedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTracked', Sort.desc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy>
      thenByIsVisibleOnApp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVisibleOnApp', Sort.asc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy>
      thenByIsVisibleOnAppDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVisibleOnApp', Sort.desc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> thenByNutrientKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nutrientKey', Sort.asc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy>
      thenByNutrientKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nutrientKey', Sort.desc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> thenByRdaOrAi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rdaOrAi', Sort.asc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> thenByRdaOrAiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rdaOrAi', Sort.desc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> thenByUl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ul', Sort.asc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> thenByUlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ul', Sort.desc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> thenByUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.asc);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QAfterSortBy> thenByUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.desc);
    });
  }
}

extension NutrientInfoQueryWhereDistinct
    on QueryBuilder<NutrientInfo, NutrientInfo, QDistinct> {
  QueryBuilder<NutrientInfo, NutrientInfo, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QDistinct> distinctByDisplayName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QDistinct> distinctByEar() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ear');
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QDistinct> distinctByFrequency(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'frequency', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QDistinct> distinctByIsTracked() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isTracked');
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QDistinct>
      distinctByIsVisibleOnApp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isVisibleOnApp');
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QDistinct> distinctByNutrientKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nutrientKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QDistinct> distinctByRdaOrAi() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rdaOrAi');
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QDistinct> distinctByUl() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ul');
    });
  }

  QueryBuilder<NutrientInfo, NutrientInfo, QDistinct> distinctByUnit(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unit', caseSensitive: caseSensitive);
    });
  }
}

extension NutrientInfoQueryProperty
    on QueryBuilder<NutrientInfo, NutrientInfo, QQueryProperty> {
  QueryBuilder<NutrientInfo, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<NutrientInfo, String?, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<NutrientInfo, String, QQueryOperations> displayNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayName');
    });
  }

  QueryBuilder<NutrientInfo, double?, QQueryOperations> earProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ear');
    });
  }

  QueryBuilder<NutrientInfo, TrackingFrequency, QQueryOperations>
      frequencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frequency');
    });
  }

  QueryBuilder<NutrientInfo, bool, QQueryOperations> isTrackedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isTracked');
    });
  }

  QueryBuilder<NutrientInfo, bool, QQueryOperations> isVisibleOnAppProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isVisibleOnApp');
    });
  }

  QueryBuilder<NutrientInfo, String, QQueryOperations> nutrientKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nutrientKey');
    });
  }

  QueryBuilder<NutrientInfo, double?, QQueryOperations> rdaOrAiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rdaOrAi');
    });
  }

  QueryBuilder<NutrientInfo, double?, QQueryOperations> ulProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ul');
    });
  }

  QueryBuilder<NutrientInfo, String, QQueryOperations> unitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unit');
    });
  }
}
