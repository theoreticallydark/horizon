// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDailyRecordCollection on Isar {
  IsarCollection<DailyRecord> get dailyRecords => this.collection();
}

const DailyRecordSchema = CollectionSchema(
  name: r'DailyRecord',
  id: -1016922496390167466,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'isSynced': PropertySchema(
      id: 1,
      name: r'isSynced',
      type: IsarType.bool,
    ),
    r'loggedFoods': PropertySchema(
      id: 2,
      name: r'loggedFoods',
      type: IsarType.objectList,
      target: r'DailyFoodLogEntry',
    ),
    r'nutrientSummaries': PropertySchema(
      id: 3,
      name: r'nutrientSummaries',
      type: IsarType.objectList,
      target: r'DailyNutrientSummary',
    ),
    r'routineAdherencePercent': PropertySchema(
      id: 4,
      name: r'routineAdherencePercent',
      type: IsarType.double,
    )
  },
  estimateSize: _dailyRecordEstimateSize,
  serialize: _dailyRecordSerialize,
  deserialize: _dailyRecordDeserialize,
  deserializeProp: _dailyRecordDeserializeProp,
  idName: r'id',
  indexes: {
    r'date': IndexSchema(
      id: -7552997827385218417,
      name: r'date',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'date',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isSynced': IndexSchema(
      id: -39763503327887510,
      name: r'isSynced',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isSynced',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'DailyFoodLogEntry': DailyFoodLogEntrySchema,
    r'DailyNutrientSummary': DailyNutrientSummarySchema
  },
  getId: _dailyRecordGetId,
  getLinks: _dailyRecordGetLinks,
  attach: _dailyRecordAttach,
  version: '3.1.0+1',
);

int _dailyRecordEstimateSize(
  DailyRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.loggedFoods.length * 3;
  {
    final offsets = allOffsets[DailyFoodLogEntry]!;
    for (var i = 0; i < object.loggedFoods.length; i++) {
      final value = object.loggedFoods[i];
      bytesCount +=
          DailyFoodLogEntrySchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.nutrientSummaries.length * 3;
  {
    final offsets = allOffsets[DailyNutrientSummary]!;
    for (var i = 0; i < object.nutrientSummaries.length; i++) {
      final value = object.nutrientSummaries[i];
      bytesCount +=
          DailyNutrientSummarySchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _dailyRecordSerialize(
  DailyRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeBool(offsets[1], object.isSynced);
  writer.writeObjectList<DailyFoodLogEntry>(
    offsets[2],
    allOffsets,
    DailyFoodLogEntrySchema.serialize,
    object.loggedFoods,
  );
  writer.writeObjectList<DailyNutrientSummary>(
    offsets[3],
    allOffsets,
    DailyNutrientSummarySchema.serialize,
    object.nutrientSummaries,
  );
  writer.writeDouble(offsets[4], object.routineAdherencePercent);
}

DailyRecord _dailyRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DailyRecord();
  object.date = reader.readDateTime(offsets[0]);
  object.id = id;
  object.isSynced = reader.readBool(offsets[1]);
  object.loggedFoods = reader.readObjectList<DailyFoodLogEntry>(
        offsets[2],
        DailyFoodLogEntrySchema.deserialize,
        allOffsets,
        DailyFoodLogEntry(),
      ) ??
      [];
  object.nutrientSummaries = reader.readObjectList<DailyNutrientSummary>(
        offsets[3],
        DailyNutrientSummarySchema.deserialize,
        allOffsets,
        DailyNutrientSummary(),
      ) ??
      [];
  object.routineAdherencePercent = reader.readDouble(offsets[4]);
  return object;
}

P _dailyRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readObjectList<DailyFoodLogEntry>(
            offset,
            DailyFoodLogEntrySchema.deserialize,
            allOffsets,
            DailyFoodLogEntry(),
          ) ??
          []) as P;
    case 3:
      return (reader.readObjectList<DailyNutrientSummary>(
            offset,
            DailyNutrientSummarySchema.deserialize,
            allOffsets,
            DailyNutrientSummary(),
          ) ??
          []) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dailyRecordGetId(DailyRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dailyRecordGetLinks(DailyRecord object) {
  return [];
}

void _dailyRecordAttach(
    IsarCollection<dynamic> col, Id id, DailyRecord object) {
  object.id = id;
}

extension DailyRecordByIndex on IsarCollection<DailyRecord> {
  Future<DailyRecord?> getByDate(DateTime date) {
    return getByIndex(r'date', [date]);
  }

  DailyRecord? getByDateSync(DateTime date) {
    return getByIndexSync(r'date', [date]);
  }

  Future<bool> deleteByDate(DateTime date) {
    return deleteByIndex(r'date', [date]);
  }

  bool deleteByDateSync(DateTime date) {
    return deleteByIndexSync(r'date', [date]);
  }

  Future<List<DailyRecord?>> getAllByDate(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return getAllByIndex(r'date', values);
  }

  List<DailyRecord?> getAllByDateSync(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'date', values);
  }

  Future<int> deleteAllByDate(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'date', values);
  }

  int deleteAllByDateSync(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'date', values);
  }

  Future<Id> putByDate(DailyRecord object) {
    return putByIndex(r'date', object);
  }

  Id putByDateSync(DailyRecord object, {bool saveLinks = true}) {
    return putByIndexSync(r'date', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDate(List<DailyRecord> objects) {
    return putAllByIndex(r'date', objects);
  }

  List<Id> putAllByDateSync(List<DailyRecord> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'date', objects, saveLinks: saveLinks);
  }
}

extension DailyRecordQueryWhereSort
    on QueryBuilder<DailyRecord, DailyRecord, QWhere> {
  QueryBuilder<DailyRecord, DailyRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterWhere> anyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'date'),
      );
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterWhere> anyIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isSynced'),
      );
    });
  }
}

extension DailyRecordQueryWhere
    on QueryBuilder<DailyRecord, DailyRecord, QWhereClause> {
  QueryBuilder<DailyRecord, DailyRecord, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<DailyRecord, DailyRecord, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterWhereClause> idBetween(
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

  QueryBuilder<DailyRecord, DailyRecord, QAfterWhereClause> dateEqualTo(
      DateTime date) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date',
        value: [date],
      ));
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterWhereClause> dateNotEqualTo(
      DateTime date) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterWhereClause> dateGreaterThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [date],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterWhereClause> dateLessThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [],
        upper: [date],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterWhereClause> dateBetween(
    DateTime lowerDate,
    DateTime upperDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [lowerDate],
        includeLower: includeLower,
        upper: [upperDate],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterWhereClause> isSyncedEqualTo(
      bool isSynced) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isSynced',
        value: [isSynced],
      ));
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterWhereClause> isSyncedNotEqualTo(
      bool isSynced) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSynced',
              lower: [],
              upper: [isSynced],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSynced',
              lower: [isSynced],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSynced',
              lower: [isSynced],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSynced',
              lower: [],
              upper: [isSynced],
              includeUpper: false,
            ));
      }
    });
  }
}

extension DailyRecordQueryFilter
    on QueryBuilder<DailyRecord, DailyRecord, QFilterCondition> {
  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition> idBetween(
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

  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition> isSyncedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSynced',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition>
      loggedFoodsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'loggedFoods',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition>
      loggedFoodsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'loggedFoods',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition>
      loggedFoodsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'loggedFoods',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition>
      loggedFoodsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'loggedFoods',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition>
      loggedFoodsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'loggedFoods',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition>
      loggedFoodsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'loggedFoods',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition>
      nutrientSummariesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nutrientSummaries',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition>
      nutrientSummariesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nutrientSummaries',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition>
      nutrientSummariesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nutrientSummaries',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition>
      nutrientSummariesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nutrientSummaries',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition>
      nutrientSummariesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nutrientSummaries',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition>
      nutrientSummariesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nutrientSummaries',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition>
      routineAdherencePercentEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'routineAdherencePercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition>
      routineAdherencePercentGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'routineAdherencePercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition>
      routineAdherencePercentLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'routineAdherencePercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition>
      routineAdherencePercentBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'routineAdherencePercent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension DailyRecordQueryObject
    on QueryBuilder<DailyRecord, DailyRecord, QFilterCondition> {
  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition>
      loggedFoodsElement(FilterQuery<DailyFoodLogEntry> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'loggedFoods');
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterFilterCondition>
      nutrientSummariesElement(FilterQuery<DailyNutrientSummary> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'nutrientSummaries');
    });
  }
}

extension DailyRecordQueryLinks
    on QueryBuilder<DailyRecord, DailyRecord, QFilterCondition> {}

extension DailyRecordQuerySortBy
    on QueryBuilder<DailyRecord, DailyRecord, QSortBy> {
  QueryBuilder<DailyRecord, DailyRecord, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterSortBy> sortByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterSortBy> sortByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterSortBy>
      sortByRoutineAdherencePercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineAdherencePercent', Sort.asc);
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterSortBy>
      sortByRoutineAdherencePercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineAdherencePercent', Sort.desc);
    });
  }
}

extension DailyRecordQuerySortThenBy
    on QueryBuilder<DailyRecord, DailyRecord, QSortThenBy> {
  QueryBuilder<DailyRecord, DailyRecord, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterSortBy> thenByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterSortBy> thenByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterSortBy>
      thenByRoutineAdherencePercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineAdherencePercent', Sort.asc);
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QAfterSortBy>
      thenByRoutineAdherencePercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineAdherencePercent', Sort.desc);
    });
  }
}

extension DailyRecordQueryWhereDistinct
    on QueryBuilder<DailyRecord, DailyRecord, QDistinct> {
  QueryBuilder<DailyRecord, DailyRecord, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QDistinct> distinctByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSynced');
    });
  }

  QueryBuilder<DailyRecord, DailyRecord, QDistinct>
      distinctByRoutineAdherencePercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'routineAdherencePercent');
    });
  }
}

extension DailyRecordQueryProperty
    on QueryBuilder<DailyRecord, DailyRecord, QQueryProperty> {
  QueryBuilder<DailyRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DailyRecord, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<DailyRecord, bool, QQueryOperations> isSyncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSynced');
    });
  }

  QueryBuilder<DailyRecord, List<DailyFoodLogEntry>, QQueryOperations>
      loggedFoodsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loggedFoods');
    });
  }

  QueryBuilder<DailyRecord, List<DailyNutrientSummary>, QQueryOperations>
      nutrientSummariesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nutrientSummaries');
    });
  }

  QueryBuilder<DailyRecord, double, QQueryOperations>
      routineAdherencePercentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'routineAdherencePercent');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DailyFoodLogEntrySchema = Schema(
  name: r'DailyFoodLogEntry',
  id: 2823341316557612288,
  properties: {
    r'amountConsumedGrams': PropertySchema(
      id: 0,
      name: r'amountConsumedGrams',
      type: IsarType.double,
    ),
    r'foodId': PropertySchema(
      id: 1,
      name: r'foodId',
      type: IsarType.string,
    ),
    r'foodTitle': PropertySchema(
      id: 2,
      name: r'foodTitle',
      type: IsarType.string,
    ),
    r'isFromRoutine': PropertySchema(
      id: 3,
      name: r'isFromRoutine',
      type: IsarType.bool,
    ),
    r'loggedAt': PropertySchema(
      id: 4,
      name: r'loggedAt',
      type: IsarType.dateTime,
    ),
    r'plannedGrams': PropertySchema(
      id: 5,
      name: r'plannedGrams',
      type: IsarType.double,
    )
  },
  estimateSize: _dailyFoodLogEntryEstimateSize,
  serialize: _dailyFoodLogEntrySerialize,
  deserialize: _dailyFoodLogEntryDeserialize,
  deserializeProp: _dailyFoodLogEntryDeserializeProp,
);

int _dailyFoodLogEntryEstimateSize(
  DailyFoodLogEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.foodId.length * 3;
  bytesCount += 3 + object.foodTitle.length * 3;
  return bytesCount;
}

void _dailyFoodLogEntrySerialize(
  DailyFoodLogEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.amountConsumedGrams);
  writer.writeString(offsets[1], object.foodId);
  writer.writeString(offsets[2], object.foodTitle);
  writer.writeBool(offsets[3], object.isFromRoutine);
  writer.writeDateTime(offsets[4], object.loggedAt);
  writer.writeDouble(offsets[5], object.plannedGrams);
}

DailyFoodLogEntry _dailyFoodLogEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DailyFoodLogEntry();
  object.amountConsumedGrams = reader.readDouble(offsets[0]);
  object.foodId = reader.readString(offsets[1]);
  object.foodTitle = reader.readString(offsets[2]);
  object.isFromRoutine = reader.readBool(offsets[3]);
  object.loggedAt = reader.readDateTime(offsets[4]);
  object.plannedGrams = reader.readDouble(offsets[5]);
  return object;
}

P _dailyFoodLogEntryDeserializeProp<P>(
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
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DailyFoodLogEntryQueryFilter
    on QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QFilterCondition> {
  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      amountConsumedGramsEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amountConsumedGrams',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      amountConsumedGramsGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amountConsumedGrams',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      amountConsumedGramsLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amountConsumedGrams',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      amountConsumedGramsBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amountConsumedGrams',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
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

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
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

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
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

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
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

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
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

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
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

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      foodIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'foodId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      foodIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'foodId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      foodIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foodId',
        value: '',
      ));
    });
  }

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      foodIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'foodId',
        value: '',
      ));
    });
  }

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      foodTitleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foodTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      foodTitleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'foodTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      foodTitleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'foodTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      foodTitleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'foodTitle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      foodTitleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'foodTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      foodTitleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'foodTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      foodTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'foodTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      foodTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'foodTitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      foodTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foodTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      foodTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'foodTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      isFromRoutineEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFromRoutine',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      loggedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loggedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      loggedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'loggedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      loggedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'loggedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      loggedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'loggedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      plannedGramsEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plannedGrams',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      plannedGramsGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'plannedGrams',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      plannedGramsLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'plannedGrams',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QAfterFilterCondition>
      plannedGramsBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'plannedGrams',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension DailyFoodLogEntryQueryObject
    on QueryBuilder<DailyFoodLogEntry, DailyFoodLogEntry, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const DailyNutrientSummarySchema = Schema(
  name: r'DailyNutrientSummary',
  id: -3848451425748980531,
  properties: {
    r'amountConsumed': PropertySchema(
      id: 0,
      name: r'amountConsumed',
      type: IsarType.double,
    ),
    r'nutrientKey': PropertySchema(
      id: 1,
      name: r'nutrientKey',
      type: IsarType.string,
    ),
    r'percentageMet': PropertySchema(
      id: 2,
      name: r'percentageMet',
      type: IsarType.double,
    ),
    r'targetAmount': PropertySchema(
      id: 3,
      name: r'targetAmount',
      type: IsarType.double,
    )
  },
  estimateSize: _dailyNutrientSummaryEstimateSize,
  serialize: _dailyNutrientSummarySerialize,
  deserialize: _dailyNutrientSummaryDeserialize,
  deserializeProp: _dailyNutrientSummaryDeserializeProp,
);

int _dailyNutrientSummaryEstimateSize(
  DailyNutrientSummary object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nutrientKey.length * 3;
  return bytesCount;
}

void _dailyNutrientSummarySerialize(
  DailyNutrientSummary object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.amountConsumed);
  writer.writeString(offsets[1], object.nutrientKey);
  writer.writeDouble(offsets[2], object.percentageMet);
  writer.writeDouble(offsets[3], object.targetAmount);
}

DailyNutrientSummary _dailyNutrientSummaryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DailyNutrientSummary();
  object.amountConsumed = reader.readDouble(offsets[0]);
  object.nutrientKey = reader.readString(offsets[1]);
  object.percentageMet = reader.readDouble(offsets[2]);
  object.targetAmount = reader.readDouble(offsets[3]);
  return object;
}

P _dailyNutrientSummaryDeserializeProp<P>(
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
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension DailyNutrientSummaryQueryFilter on QueryBuilder<DailyNutrientSummary,
    DailyNutrientSummary, QFilterCondition> {
  QueryBuilder<DailyNutrientSummary, DailyNutrientSummary,
      QAfterFilterCondition> amountConsumedEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amountConsumed',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyNutrientSummary, DailyNutrientSummary,
      QAfterFilterCondition> amountConsumedGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amountConsumed',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyNutrientSummary, DailyNutrientSummary,
      QAfterFilterCondition> amountConsumedLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amountConsumed',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyNutrientSummary, DailyNutrientSummary,
      QAfterFilterCondition> amountConsumedBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amountConsumed',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyNutrientSummary, DailyNutrientSummary,
      QAfterFilterCondition> nutrientKeyEqualTo(
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

  QueryBuilder<DailyNutrientSummary, DailyNutrientSummary,
      QAfterFilterCondition> nutrientKeyGreaterThan(
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

  QueryBuilder<DailyNutrientSummary, DailyNutrientSummary,
      QAfterFilterCondition> nutrientKeyLessThan(
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

  QueryBuilder<DailyNutrientSummary, DailyNutrientSummary,
      QAfterFilterCondition> nutrientKeyBetween(
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

  QueryBuilder<DailyNutrientSummary, DailyNutrientSummary,
      QAfterFilterCondition> nutrientKeyStartsWith(
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

  QueryBuilder<DailyNutrientSummary, DailyNutrientSummary,
      QAfterFilterCondition> nutrientKeyEndsWith(
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

  QueryBuilder<DailyNutrientSummary, DailyNutrientSummary,
          QAfterFilterCondition>
      nutrientKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nutrientKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyNutrientSummary, DailyNutrientSummary,
          QAfterFilterCondition>
      nutrientKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nutrientKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DailyNutrientSummary, DailyNutrientSummary,
      QAfterFilterCondition> nutrientKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nutrientKey',
        value: '',
      ));
    });
  }

  QueryBuilder<DailyNutrientSummary, DailyNutrientSummary,
      QAfterFilterCondition> nutrientKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nutrientKey',
        value: '',
      ));
    });
  }

  QueryBuilder<DailyNutrientSummary, DailyNutrientSummary,
      QAfterFilterCondition> percentageMetEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'percentageMet',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyNutrientSummary, DailyNutrientSummary,
      QAfterFilterCondition> percentageMetGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'percentageMet',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyNutrientSummary, DailyNutrientSummary,
      QAfterFilterCondition> percentageMetLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'percentageMet',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyNutrientSummary, DailyNutrientSummary,
      QAfterFilterCondition> percentageMetBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'percentageMet',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyNutrientSummary, DailyNutrientSummary,
      QAfterFilterCondition> targetAmountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyNutrientSummary, DailyNutrientSummary,
      QAfterFilterCondition> targetAmountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyNutrientSummary, DailyNutrientSummary,
      QAfterFilterCondition> targetAmountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyNutrientSummary, DailyNutrientSummary,
      QAfterFilterCondition> targetAmountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension DailyNutrientSummaryQueryObject on QueryBuilder<DailyNutrientSummary,
    DailyNutrientSummary, QFilterCondition> {}
