// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTrackRecordCollection on Isar {
  IsarCollection<TrackRecord> get trackRecords => this.collection();
}

const TrackRecordSchema = CollectionSchema(
  name: r'TrackRecord',
  id: 7443229866473957398,
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
      target: r'TrackedFoodEntry',
    ),
    r'nutrientSummaries': PropertySchema(
      id: 3,
      name: r'nutrientSummaries',
      type: IsarType.objectList,
      target: r'TrackNutrientSummary',
    ),
    r'routineAdherencePercent': PropertySchema(
      id: 4,
      name: r'routineAdherencePercent',
      type: IsarType.double,
    )
  },
  estimateSize: _trackRecordEstimateSize,
  serialize: _trackRecordSerialize,
  deserialize: _trackRecordDeserialize,
  deserializeProp: _trackRecordDeserializeProp,
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
    r'TrackedFoodEntry': TrackedFoodEntrySchema,
    r'TrackNutrientSummary': TrackNutrientSummarySchema
  },
  getId: _trackRecordGetId,
  getLinks: _trackRecordGetLinks,
  attach: _trackRecordAttach,
  version: '3.1.0+1',
);

int _trackRecordEstimateSize(
  TrackRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.loggedFoods.length * 3;
  {
    final offsets = allOffsets[TrackedFoodEntry]!;
    for (var i = 0; i < object.loggedFoods.length; i++) {
      final value = object.loggedFoods[i];
      bytesCount +=
          TrackedFoodEntrySchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.nutrientSummaries.length * 3;
  {
    final offsets = allOffsets[TrackNutrientSummary]!;
    for (var i = 0; i < object.nutrientSummaries.length; i++) {
      final value = object.nutrientSummaries[i];
      bytesCount +=
          TrackNutrientSummarySchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _trackRecordSerialize(
  TrackRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeBool(offsets[1], object.isSynced);
  writer.writeObjectList<TrackedFoodEntry>(
    offsets[2],
    allOffsets,
    TrackedFoodEntrySchema.serialize,
    object.loggedFoods,
  );
  writer.writeObjectList<TrackNutrientSummary>(
    offsets[3],
    allOffsets,
    TrackNutrientSummarySchema.serialize,
    object.nutrientSummaries,
  );
  writer.writeDouble(offsets[4], object.routineAdherencePercent);
}

TrackRecord _trackRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TrackRecord();
  object.date = reader.readDateTime(offsets[0]);
  object.id = id;
  object.isSynced = reader.readBool(offsets[1]);
  object.loggedFoods = reader.readObjectList<TrackedFoodEntry>(
        offsets[2],
        TrackedFoodEntrySchema.deserialize,
        allOffsets,
        TrackedFoodEntry(),
      ) ??
      [];
  object.nutrientSummaries = reader.readObjectList<TrackNutrientSummary>(
        offsets[3],
        TrackNutrientSummarySchema.deserialize,
        allOffsets,
        TrackNutrientSummary(),
      ) ??
      [];
  object.routineAdherencePercent = reader.readDouble(offsets[4]);
  return object;
}

P _trackRecordDeserializeProp<P>(
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
      return (reader.readObjectList<TrackedFoodEntry>(
            offset,
            TrackedFoodEntrySchema.deserialize,
            allOffsets,
            TrackedFoodEntry(),
          ) ??
          []) as P;
    case 3:
      return (reader.readObjectList<TrackNutrientSummary>(
            offset,
            TrackNutrientSummarySchema.deserialize,
            allOffsets,
            TrackNutrientSummary(),
          ) ??
          []) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _trackRecordGetId(TrackRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _trackRecordGetLinks(TrackRecord object) {
  return [];
}

void _trackRecordAttach(
    IsarCollection<dynamic> col, Id id, TrackRecord object) {
  object.id = id;
}

extension TrackRecordByIndex on IsarCollection<TrackRecord> {
  Future<TrackRecord?> getByDate(DateTime date) {
    return getByIndex(r'date', [date]);
  }

  TrackRecord? getByDateSync(DateTime date) {
    return getByIndexSync(r'date', [date]);
  }

  Future<bool> deleteByDate(DateTime date) {
    return deleteByIndex(r'date', [date]);
  }

  bool deleteByDateSync(DateTime date) {
    return deleteByIndexSync(r'date', [date]);
  }

  Future<List<TrackRecord?>> getAllByDate(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return getAllByIndex(r'date', values);
  }

  List<TrackRecord?> getAllByDateSync(List<DateTime> dateValues) {
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

  Future<Id> putByDate(TrackRecord object) {
    return putByIndex(r'date', object);
  }

  Id putByDateSync(TrackRecord object, {bool saveLinks = true}) {
    return putByIndexSync(r'date', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDate(List<TrackRecord> objects) {
    return putAllByIndex(r'date', objects);
  }

  List<Id> putAllByDateSync(List<TrackRecord> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'date', objects, saveLinks: saveLinks);
  }
}

extension TrackRecordQueryWhereSort
    on QueryBuilder<TrackRecord, TrackRecord, QWhere> {
  QueryBuilder<TrackRecord, TrackRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<TrackRecord, TrackRecord, QAfterWhere> anyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'date'),
      );
    });
  }

  QueryBuilder<TrackRecord, TrackRecord, QAfterWhere> anyIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isSynced'),
      );
    });
  }
}

extension TrackRecordQueryWhere
    on QueryBuilder<TrackRecord, TrackRecord, QWhereClause> {
  QueryBuilder<TrackRecord, TrackRecord, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TrackRecord, TrackRecord, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TrackRecord, TrackRecord, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TrackRecord, TrackRecord, QAfterWhereClause> idBetween(
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterWhereClause> dateEqualTo(
      DateTime date) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date',
        value: [date],
      ));
    });
  }

  QueryBuilder<TrackRecord, TrackRecord, QAfterWhereClause> dateNotEqualTo(
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterWhereClause> dateGreaterThan(
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterWhereClause> dateLessThan(
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterWhereClause> dateBetween(
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterWhereClause> isSyncedEqualTo(
      bool isSynced) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isSynced',
        value: [isSynced],
      ));
    });
  }

  QueryBuilder<TrackRecord, TrackRecord, QAfterWhereClause> isSyncedNotEqualTo(
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

extension TrackRecordQueryFilter
    on QueryBuilder<TrackRecord, TrackRecord, QFilterCondition> {
  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition> dateGreaterThan(
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition> dateLessThan(
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition> dateBetween(
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition> idBetween(
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition> isSyncedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSynced',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition>
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition>
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition>
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition>
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition>
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition>
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition>
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition>
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition>
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition>
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition>
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition>
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition>
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition>
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition>
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

  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition>
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

extension TrackRecordQueryObject
    on QueryBuilder<TrackRecord, TrackRecord, QFilterCondition> {
  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition>
      loggedFoodsElement(FilterQuery<TrackedFoodEntry> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'loggedFoods');
    });
  }

  QueryBuilder<TrackRecord, TrackRecord, QAfterFilterCondition>
      nutrientSummariesElement(FilterQuery<TrackNutrientSummary> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'nutrientSummaries');
    });
  }
}

extension TrackRecordQueryLinks
    on QueryBuilder<TrackRecord, TrackRecord, QFilterCondition> {}

extension TrackRecordQuerySortBy
    on QueryBuilder<TrackRecord, TrackRecord, QSortBy> {
  QueryBuilder<TrackRecord, TrackRecord, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<TrackRecord, TrackRecord, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<TrackRecord, TrackRecord, QAfterSortBy> sortByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<TrackRecord, TrackRecord, QAfterSortBy> sortByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<TrackRecord, TrackRecord, QAfterSortBy>
      sortByRoutineAdherencePercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineAdherencePercent', Sort.asc);
    });
  }

  QueryBuilder<TrackRecord, TrackRecord, QAfterSortBy>
      sortByRoutineAdherencePercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineAdherencePercent', Sort.desc);
    });
  }
}

extension TrackRecordQuerySortThenBy
    on QueryBuilder<TrackRecord, TrackRecord, QSortThenBy> {
  QueryBuilder<TrackRecord, TrackRecord, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<TrackRecord, TrackRecord, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<TrackRecord, TrackRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TrackRecord, TrackRecord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TrackRecord, TrackRecord, QAfterSortBy> thenByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<TrackRecord, TrackRecord, QAfterSortBy> thenByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<TrackRecord, TrackRecord, QAfterSortBy>
      thenByRoutineAdherencePercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineAdherencePercent', Sort.asc);
    });
  }

  QueryBuilder<TrackRecord, TrackRecord, QAfterSortBy>
      thenByRoutineAdherencePercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineAdherencePercent', Sort.desc);
    });
  }
}

extension TrackRecordQueryWhereDistinct
    on QueryBuilder<TrackRecord, TrackRecord, QDistinct> {
  QueryBuilder<TrackRecord, TrackRecord, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<TrackRecord, TrackRecord, QDistinct> distinctByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSynced');
    });
  }

  QueryBuilder<TrackRecord, TrackRecord, QDistinct>
      distinctByRoutineAdherencePercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'routineAdherencePercent');
    });
  }
}

extension TrackRecordQueryProperty
    on QueryBuilder<TrackRecord, TrackRecord, QQueryProperty> {
  QueryBuilder<TrackRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TrackRecord, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<TrackRecord, bool, QQueryOperations> isSyncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSynced');
    });
  }

  QueryBuilder<TrackRecord, List<TrackedFoodEntry>, QQueryOperations>
      loggedFoodsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loggedFoods');
    });
  }

  QueryBuilder<TrackRecord, List<TrackNutrientSummary>, QQueryOperations>
      nutrientSummariesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nutrientSummaries');
    });
  }

  QueryBuilder<TrackRecord, double, QQueryOperations>
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

const TrackedFoodEntrySchema = Schema(
  name: r'TrackedFoodEntry',
  id: 553257056315010556,
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
  estimateSize: _trackedFoodEntryEstimateSize,
  serialize: _trackedFoodEntrySerialize,
  deserialize: _trackedFoodEntryDeserialize,
  deserializeProp: _trackedFoodEntryDeserializeProp,
);

int _trackedFoodEntryEstimateSize(
  TrackedFoodEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.foodId.length * 3;
  bytesCount += 3 + object.foodTitle.length * 3;
  return bytesCount;
}

void _trackedFoodEntrySerialize(
  TrackedFoodEntry object,
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

TrackedFoodEntry _trackedFoodEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TrackedFoodEntry();
  object.amountConsumedGrams = reader.readDouble(offsets[0]);
  object.foodId = reader.readString(offsets[1]);
  object.foodTitle = reader.readString(offsets[2]);
  object.isFromRoutine = reader.readBool(offsets[3]);
  object.loggedAt = reader.readDateTime(offsets[4]);
  object.plannedGrams = reader.readDouble(offsets[5]);
  return object;
}

P _trackedFoodEntryDeserializeProp<P>(
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

extension TrackedFoodEntryQueryFilter
    on QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QFilterCondition> {
  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
      foodIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'foodId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
      foodIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'foodId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
      foodIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foodId',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
      foodIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'foodId',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
      foodTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'foodTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
      foodTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'foodTitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
      foodTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foodTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
      foodTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'foodTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
      isFromRoutineEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFromRoutine',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
      loggedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loggedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

extension TrackedFoodEntryQueryObject
    on QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const TrackNutrientSummarySchema = Schema(
  name: r'TrackNutrientSummary',
  id: 1271499436745330573,
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
  estimateSize: _trackNutrientSummaryEstimateSize,
  serialize: _trackNutrientSummarySerialize,
  deserialize: _trackNutrientSummaryDeserialize,
  deserializeProp: _trackNutrientSummaryDeserializeProp,
);

int _trackNutrientSummaryEstimateSize(
  TrackNutrientSummary object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nutrientKey.length * 3;
  return bytesCount;
}

void _trackNutrientSummarySerialize(
  TrackNutrientSummary object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.amountConsumed);
  writer.writeString(offsets[1], object.nutrientKey);
  writer.writeDouble(offsets[2], object.percentageMet);
  writer.writeDouble(offsets[3], object.targetAmount);
}

TrackNutrientSummary _trackNutrientSummaryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TrackNutrientSummary();
  object.amountConsumed = reader.readDouble(offsets[0]);
  object.nutrientKey = reader.readString(offsets[1]);
  object.percentageMet = reader.readDouble(offsets[2]);
  object.targetAmount = reader.readDouble(offsets[3]);
  return object;
}

P _trackNutrientSummaryDeserializeProp<P>(
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

extension TrackNutrientSummaryQueryFilter on QueryBuilder<TrackNutrientSummary,
    TrackNutrientSummary, QFilterCondition> {
  QueryBuilder<TrackNutrientSummary, TrackNutrientSummary,
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

  QueryBuilder<TrackNutrientSummary, TrackNutrientSummary,
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

  QueryBuilder<TrackNutrientSummary, TrackNutrientSummary,
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

  QueryBuilder<TrackNutrientSummary, TrackNutrientSummary,
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

  QueryBuilder<TrackNutrientSummary, TrackNutrientSummary,
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

  QueryBuilder<TrackNutrientSummary, TrackNutrientSummary,
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

  QueryBuilder<TrackNutrientSummary, TrackNutrientSummary,
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

  QueryBuilder<TrackNutrientSummary, TrackNutrientSummary,
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

  QueryBuilder<TrackNutrientSummary, TrackNutrientSummary,
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

  QueryBuilder<TrackNutrientSummary, TrackNutrientSummary,
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

  QueryBuilder<TrackNutrientSummary, TrackNutrientSummary,
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

  QueryBuilder<TrackNutrientSummary, TrackNutrientSummary,
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

  QueryBuilder<TrackNutrientSummary, TrackNutrientSummary,
      QAfterFilterCondition> nutrientKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nutrientKey',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackNutrientSummary, TrackNutrientSummary,
      QAfterFilterCondition> nutrientKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nutrientKey',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackNutrientSummary, TrackNutrientSummary,
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

  QueryBuilder<TrackNutrientSummary, TrackNutrientSummary,
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

  QueryBuilder<TrackNutrientSummary, TrackNutrientSummary,
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

  QueryBuilder<TrackNutrientSummary, TrackNutrientSummary,
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

  QueryBuilder<TrackNutrientSummary, TrackNutrientSummary,
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

  QueryBuilder<TrackNutrientSummary, TrackNutrientSummary,
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

  QueryBuilder<TrackNutrientSummary, TrackNutrientSummary,
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

  QueryBuilder<TrackNutrientSummary, TrackNutrientSummary,
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

extension TrackNutrientSummaryQueryObject on QueryBuilder<TrackNutrientSummary,
    TrackNutrientSummary, QFilterCondition> {}
