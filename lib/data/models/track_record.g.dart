// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTrackRecordDailyCollection on Isar {
  IsarCollection<TrackRecordDaily> get trackRecordDailys => this.collection();
}

const TrackRecordDailySchema = CollectionSchema(
  name: r'TrackRecordDaily',
  id: 234478496957495765,
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
  estimateSize: _trackRecordDailyEstimateSize,
  serialize: _trackRecordDailySerialize,
  deserialize: _trackRecordDailyDeserialize,
  deserializeProp: _trackRecordDailyDeserializeProp,
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
  getId: _trackRecordDailyGetId,
  getLinks: _trackRecordDailyGetLinks,
  attach: _trackRecordDailyAttach,
  version: '3.1.0+1',
);

int _trackRecordDailyEstimateSize(
  TrackRecordDaily object,
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

void _trackRecordDailySerialize(
  TrackRecordDaily object,
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

TrackRecordDaily _trackRecordDailyDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TrackRecordDaily();
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

P _trackRecordDailyDeserializeProp<P>(
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

Id _trackRecordDailyGetId(TrackRecordDaily object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _trackRecordDailyGetLinks(TrackRecordDaily object) {
  return [];
}

void _trackRecordDailyAttach(
    IsarCollection<dynamic> col, Id id, TrackRecordDaily object) {
  object.id = id;
}

extension TrackRecordDailyByIndex on IsarCollection<TrackRecordDaily> {
  Future<TrackRecordDaily?> getByDate(DateTime date) {
    return getByIndex(r'date', [date]);
  }

  TrackRecordDaily? getByDateSync(DateTime date) {
    return getByIndexSync(r'date', [date]);
  }

  Future<bool> deleteByDate(DateTime date) {
    return deleteByIndex(r'date', [date]);
  }

  bool deleteByDateSync(DateTime date) {
    return deleteByIndexSync(r'date', [date]);
  }

  Future<List<TrackRecordDaily?>> getAllByDate(List<DateTime> dateValues) {
    final values = dateValues.map((e) => [e]).toList();
    return getAllByIndex(r'date', values);
  }

  List<TrackRecordDaily?> getAllByDateSync(List<DateTime> dateValues) {
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

  Future<Id> putByDate(TrackRecordDaily object) {
    return putByIndex(r'date', object);
  }

  Id putByDateSync(TrackRecordDaily object, {bool saveLinks = true}) {
    return putByIndexSync(r'date', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDate(List<TrackRecordDaily> objects) {
    return putAllByIndex(r'date', objects);
  }

  List<Id> putAllByDateSync(List<TrackRecordDaily> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'date', objects, saveLinks: saveLinks);
  }
}

extension TrackRecordDailyQueryWhereSort
    on QueryBuilder<TrackRecordDaily, TrackRecordDaily, QWhere> {
  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterWhere> anyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'date'),
      );
    });
  }

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterWhere> anyIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isSynced'),
      );
    });
  }
}

extension TrackRecordDailyQueryWhere
    on QueryBuilder<TrackRecordDaily, TrackRecordDaily, QWhereClause> {
  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterWhereClause> idBetween(
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterWhereClause>
      dateEqualTo(DateTime date) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date',
        value: [date],
      ));
    });
  }

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterWhereClause>
      dateNotEqualTo(DateTime date) {
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterWhereClause>
      dateGreaterThan(
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterWhereClause>
      dateLessThan(
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterWhereClause>
      dateBetween(
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterWhereClause>
      isSyncedEqualTo(bool isSynced) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isSynced',
        value: [isSynced],
      ));
    });
  }

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterWhereClause>
      isSyncedNotEqualTo(bool isSynced) {
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

extension TrackRecordDailyQueryFilter
    on QueryBuilder<TrackRecordDaily, TrackRecordDaily, QFilterCondition> {
  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
      dateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
      dateGreaterThan(
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
      dateLessThan(
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
      dateBetween(
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
      isSyncedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSynced',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
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

extension TrackRecordDailyQueryObject
    on QueryBuilder<TrackRecordDaily, TrackRecordDaily, QFilterCondition> {
  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
      loggedFoodsElement(FilterQuery<TrackedFoodEntry> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'loggedFoods');
    });
  }

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterFilterCondition>
      nutrientSummariesElement(FilterQuery<TrackNutrientSummary> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'nutrientSummaries');
    });
  }
}

extension TrackRecordDailyQueryLinks
    on QueryBuilder<TrackRecordDaily, TrackRecordDaily, QFilterCondition> {}

extension TrackRecordDailyQuerySortBy
    on QueryBuilder<TrackRecordDaily, TrackRecordDaily, QSortBy> {
  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterSortBy>
      sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterSortBy>
      sortByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterSortBy>
      sortByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterSortBy>
      sortByRoutineAdherencePercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineAdherencePercent', Sort.asc);
    });
  }

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterSortBy>
      sortByRoutineAdherencePercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineAdherencePercent', Sort.desc);
    });
  }
}

extension TrackRecordDailyQuerySortThenBy
    on QueryBuilder<TrackRecordDaily, TrackRecordDaily, QSortThenBy> {
  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterSortBy>
      thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterSortBy>
      thenByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterSortBy>
      thenByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterSortBy>
      thenByRoutineAdherencePercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineAdherencePercent', Sort.asc);
    });
  }

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QAfterSortBy>
      thenByRoutineAdherencePercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineAdherencePercent', Sort.desc);
    });
  }
}

extension TrackRecordDailyQueryWhereDistinct
    on QueryBuilder<TrackRecordDaily, TrackRecordDaily, QDistinct> {
  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QDistinct>
      distinctByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSynced');
    });
  }

  QueryBuilder<TrackRecordDaily, TrackRecordDaily, QDistinct>
      distinctByRoutineAdherencePercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'routineAdherencePercent');
    });
  }
}

extension TrackRecordDailyQueryProperty
    on QueryBuilder<TrackRecordDaily, TrackRecordDaily, QQueryProperty> {
  QueryBuilder<TrackRecordDaily, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TrackRecordDaily, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<TrackRecordDaily, bool, QQueryOperations> isSyncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSynced');
    });
  }

  QueryBuilder<TrackRecordDaily, List<TrackedFoodEntry>, QQueryOperations>
      loggedFoodsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loggedFoods');
    });
  }

  QueryBuilder<TrackRecordDaily, List<TrackNutrientSummary>, QQueryOperations>
      nutrientSummariesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nutrientSummaries');
    });
  }

  QueryBuilder<TrackRecordDaily, double, QQueryOperations>
      routineAdherencePercentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'routineAdherencePercent');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTrackRecordWeeklyCollection on Isar {
  IsarCollection<TrackRecordWeekly> get trackRecordWeeklys => this.collection();
}

const TrackRecordWeeklySchema = CollectionSchema(
  name: r'TrackRecordWeekly',
  id: 1972696531631057949,
  properties: {
    r'isSynced': PropertySchema(
      id: 0,
      name: r'isSynced',
      type: IsarType.bool,
    ),
    r'loggedFoods': PropertySchema(
      id: 1,
      name: r'loggedFoods',
      type: IsarType.objectList,
      target: r'TrackedFoodEntry',
    ),
    r'nutrientSummaries': PropertySchema(
      id: 2,
      name: r'nutrientSummaries',
      type: IsarType.objectList,
      target: r'TrackNutrientSummary',
    ),
    r'routineAdherencePercent': PropertySchema(
      id: 3,
      name: r'routineAdherencePercent',
      type: IsarType.double,
    ),
    r'weekKey': PropertySchema(
      id: 4,
      name: r'weekKey',
      type: IsarType.string,
    ),
    r'weekStartDate': PropertySchema(
      id: 5,
      name: r'weekStartDate',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _trackRecordWeeklyEstimateSize,
  serialize: _trackRecordWeeklySerialize,
  deserialize: _trackRecordWeeklyDeserialize,
  deserializeProp: _trackRecordWeeklyDeserializeProp,
  idName: r'id',
  indexes: {
    r'weekStartDate': IndexSchema(
      id: 7906057668223877157,
      name: r'weekStartDate',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'weekStartDate',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'weekKey': IndexSchema(
      id: 2886219582654836883,
      name: r'weekKey',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'weekKey',
          type: IndexType.hash,
          caseSensitive: true,
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
  getId: _trackRecordWeeklyGetId,
  getLinks: _trackRecordWeeklyGetLinks,
  attach: _trackRecordWeeklyAttach,
  version: '3.1.0+1',
);

int _trackRecordWeeklyEstimateSize(
  TrackRecordWeekly object,
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
  bytesCount += 3 + object.weekKey.length * 3;
  return bytesCount;
}

void _trackRecordWeeklySerialize(
  TrackRecordWeekly object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isSynced);
  writer.writeObjectList<TrackedFoodEntry>(
    offsets[1],
    allOffsets,
    TrackedFoodEntrySchema.serialize,
    object.loggedFoods,
  );
  writer.writeObjectList<TrackNutrientSummary>(
    offsets[2],
    allOffsets,
    TrackNutrientSummarySchema.serialize,
    object.nutrientSummaries,
  );
  writer.writeDouble(offsets[3], object.routineAdherencePercent);
  writer.writeString(offsets[4], object.weekKey);
  writer.writeDateTime(offsets[5], object.weekStartDate);
}

TrackRecordWeekly _trackRecordWeeklyDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TrackRecordWeekly();
  object.id = id;
  object.isSynced = reader.readBool(offsets[0]);
  object.loggedFoods = reader.readObjectList<TrackedFoodEntry>(
        offsets[1],
        TrackedFoodEntrySchema.deserialize,
        allOffsets,
        TrackedFoodEntry(),
      ) ??
      [];
  object.nutrientSummaries = reader.readObjectList<TrackNutrientSummary>(
        offsets[2],
        TrackNutrientSummarySchema.deserialize,
        allOffsets,
        TrackNutrientSummary(),
      ) ??
      [];
  object.routineAdherencePercent = reader.readDouble(offsets[3]);
  object.weekKey = reader.readString(offsets[4]);
  object.weekStartDate = reader.readDateTime(offsets[5]);
  return object;
}

P _trackRecordWeeklyDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readObjectList<TrackedFoodEntry>(
            offset,
            TrackedFoodEntrySchema.deserialize,
            allOffsets,
            TrackedFoodEntry(),
          ) ??
          []) as P;
    case 2:
      return (reader.readObjectList<TrackNutrientSummary>(
            offset,
            TrackNutrientSummarySchema.deserialize,
            allOffsets,
            TrackNutrientSummary(),
          ) ??
          []) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _trackRecordWeeklyGetId(TrackRecordWeekly object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _trackRecordWeeklyGetLinks(
    TrackRecordWeekly object) {
  return [];
}

void _trackRecordWeeklyAttach(
    IsarCollection<dynamic> col, Id id, TrackRecordWeekly object) {
  object.id = id;
}

extension TrackRecordWeeklyByIndex on IsarCollection<TrackRecordWeekly> {
  Future<TrackRecordWeekly?> getByWeekStartDate(DateTime weekStartDate) {
    return getByIndex(r'weekStartDate', [weekStartDate]);
  }

  TrackRecordWeekly? getByWeekStartDateSync(DateTime weekStartDate) {
    return getByIndexSync(r'weekStartDate', [weekStartDate]);
  }

  Future<bool> deleteByWeekStartDate(DateTime weekStartDate) {
    return deleteByIndex(r'weekStartDate', [weekStartDate]);
  }

  bool deleteByWeekStartDateSync(DateTime weekStartDate) {
    return deleteByIndexSync(r'weekStartDate', [weekStartDate]);
  }

  Future<List<TrackRecordWeekly?>> getAllByWeekStartDate(
      List<DateTime> weekStartDateValues) {
    final values = weekStartDateValues.map((e) => [e]).toList();
    return getAllByIndex(r'weekStartDate', values);
  }

  List<TrackRecordWeekly?> getAllByWeekStartDateSync(
      List<DateTime> weekStartDateValues) {
    final values = weekStartDateValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'weekStartDate', values);
  }

  Future<int> deleteAllByWeekStartDate(List<DateTime> weekStartDateValues) {
    final values = weekStartDateValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'weekStartDate', values);
  }

  int deleteAllByWeekStartDateSync(List<DateTime> weekStartDateValues) {
    final values = weekStartDateValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'weekStartDate', values);
  }

  Future<Id> putByWeekStartDate(TrackRecordWeekly object) {
    return putByIndex(r'weekStartDate', object);
  }

  Id putByWeekStartDateSync(TrackRecordWeekly object, {bool saveLinks = true}) {
    return putByIndexSync(r'weekStartDate', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByWeekStartDate(List<TrackRecordWeekly> objects) {
    return putAllByIndex(r'weekStartDate', objects);
  }

  List<Id> putAllByWeekStartDateSync(List<TrackRecordWeekly> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'weekStartDate', objects, saveLinks: saveLinks);
  }
}

extension TrackRecordWeeklyQueryWhereSort
    on QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QWhere> {
  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterWhere>
      anyWeekStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'weekStartDate'),
      );
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterWhere>
      anyIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isSynced'),
      );
    });
  }
}

extension TrackRecordWeeklyQueryWhere
    on QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QWhereClause> {
  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterWhereClause>
      idBetween(
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

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterWhereClause>
      weekStartDateEqualTo(DateTime weekStartDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'weekStartDate',
        value: [weekStartDate],
      ));
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterWhereClause>
      weekStartDateNotEqualTo(DateTime weekStartDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'weekStartDate',
              lower: [],
              upper: [weekStartDate],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'weekStartDate',
              lower: [weekStartDate],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'weekStartDate',
              lower: [weekStartDate],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'weekStartDate',
              lower: [],
              upper: [weekStartDate],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterWhereClause>
      weekStartDateGreaterThan(
    DateTime weekStartDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'weekStartDate',
        lower: [weekStartDate],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterWhereClause>
      weekStartDateLessThan(
    DateTime weekStartDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'weekStartDate',
        lower: [],
        upper: [weekStartDate],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterWhereClause>
      weekStartDateBetween(
    DateTime lowerWeekStartDate,
    DateTime upperWeekStartDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'weekStartDate',
        lower: [lowerWeekStartDate],
        includeLower: includeLower,
        upper: [upperWeekStartDate],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterWhereClause>
      weekKeyEqualTo(String weekKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'weekKey',
        value: [weekKey],
      ));
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterWhereClause>
      weekKeyNotEqualTo(String weekKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'weekKey',
              lower: [],
              upper: [weekKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'weekKey',
              lower: [weekKey],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'weekKey',
              lower: [weekKey],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'weekKey',
              lower: [],
              upper: [weekKey],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterWhereClause>
      isSyncedEqualTo(bool isSynced) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isSynced',
        value: [isSynced],
      ));
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterWhereClause>
      isSyncedNotEqualTo(bool isSynced) {
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

extension TrackRecordWeeklyQueryFilter
    on QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QFilterCondition> {
  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
      isSyncedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSynced',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
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

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
      weekKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weekKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
      weekKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weekKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
      weekKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weekKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
      weekKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weekKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
      weekKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'weekKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
      weekKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'weekKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
      weekKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'weekKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
      weekKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'weekKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
      weekKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weekKey',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
      weekKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'weekKey',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
      weekStartDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weekStartDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
      weekStartDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weekStartDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
      weekStartDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weekStartDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
      weekStartDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weekStartDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TrackRecordWeeklyQueryObject
    on QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QFilterCondition> {
  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
      loggedFoodsElement(FilterQuery<TrackedFoodEntry> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'loggedFoods');
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterFilterCondition>
      nutrientSummariesElement(FilterQuery<TrackNutrientSummary> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'nutrientSummaries');
    });
  }
}

extension TrackRecordWeeklyQueryLinks
    on QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QFilterCondition> {}

extension TrackRecordWeeklyQuerySortBy
    on QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QSortBy> {
  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterSortBy>
      sortByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterSortBy>
      sortByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterSortBy>
      sortByRoutineAdherencePercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineAdherencePercent', Sort.asc);
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterSortBy>
      sortByRoutineAdherencePercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineAdherencePercent', Sort.desc);
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterSortBy>
      sortByWeekKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekKey', Sort.asc);
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterSortBy>
      sortByWeekKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekKey', Sort.desc);
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterSortBy>
      sortByWeekStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekStartDate', Sort.asc);
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterSortBy>
      sortByWeekStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekStartDate', Sort.desc);
    });
  }
}

extension TrackRecordWeeklyQuerySortThenBy
    on QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QSortThenBy> {
  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterSortBy>
      thenByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterSortBy>
      thenByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterSortBy>
      thenByRoutineAdherencePercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineAdherencePercent', Sort.asc);
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterSortBy>
      thenByRoutineAdherencePercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'routineAdherencePercent', Sort.desc);
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterSortBy>
      thenByWeekKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekKey', Sort.asc);
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterSortBy>
      thenByWeekKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekKey', Sort.desc);
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterSortBy>
      thenByWeekStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekStartDate', Sort.asc);
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QAfterSortBy>
      thenByWeekStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekStartDate', Sort.desc);
    });
  }
}

extension TrackRecordWeeklyQueryWhereDistinct
    on QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QDistinct> {
  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QDistinct>
      distinctByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSynced');
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QDistinct>
      distinctByRoutineAdherencePercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'routineAdherencePercent');
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QDistinct>
      distinctByWeekKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weekKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QDistinct>
      distinctByWeekStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weekStartDate');
    });
  }
}

extension TrackRecordWeeklyQueryProperty
    on QueryBuilder<TrackRecordWeekly, TrackRecordWeekly, QQueryProperty> {
  QueryBuilder<TrackRecordWeekly, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TrackRecordWeekly, bool, QQueryOperations> isSyncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSynced');
    });
  }

  QueryBuilder<TrackRecordWeekly, List<TrackedFoodEntry>, QQueryOperations>
      loggedFoodsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loggedFoods');
    });
  }

  QueryBuilder<TrackRecordWeekly, List<TrackNutrientSummary>, QQueryOperations>
      nutrientSummariesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nutrientSummaries');
    });
  }

  QueryBuilder<TrackRecordWeekly, double, QQueryOperations>
      routineAdherencePercentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'routineAdherencePercent');
    });
  }

  QueryBuilder<TrackRecordWeekly, String, QQueryOperations> weekKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weekKey');
    });
  }

  QueryBuilder<TrackRecordWeekly, DateTime, QQueryOperations>
      weekStartDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weekStartDate');
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
    r'frequency': PropertySchema(
      id: 3,
      name: r'frequency',
      type: IsarType.string,
      enumMap: _TrackedFoodEntryfrequencyEnumValueMap,
    ),
    r'isFromRoutine': PropertySchema(
      id: 4,
      name: r'isFromRoutine',
      type: IsarType.bool,
    ),
    r'loggedAt': PropertySchema(
      id: 5,
      name: r'loggedAt',
      type: IsarType.dateTime,
    ),
    r'plannedGrams': PropertySchema(
      id: 6,
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
  bytesCount += 3 + object.frequency.name.length * 3;
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
  writer.writeString(offsets[3], object.frequency.name);
  writer.writeBool(offsets[4], object.isFromRoutine);
  writer.writeDateTime(offsets[5], object.loggedAt);
  writer.writeDouble(offsets[6], object.plannedGrams);
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
  object.frequency = _TrackedFoodEntryfrequencyValueEnumMap[
          reader.readStringOrNull(offsets[3])] ??
      TrackingFrequency.daily;
  object.isFromRoutine = reader.readBool(offsets[4]);
  object.loggedAt = reader.readDateTime(offsets[5]);
  object.plannedGrams = reader.readDouble(offsets[6]);
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
      return (_TrackedFoodEntryfrequencyValueEnumMap[
              reader.readStringOrNull(offset)] ??
          TrackingFrequency.daily) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _TrackedFoodEntryfrequencyEnumValueMap = {
  r'daily': r'daily',
  r'weekly': r'weekly',
};
const _TrackedFoodEntryfrequencyValueEnumMap = {
  r'daily': TrackingFrequency.daily,
  r'weekly': TrackingFrequency.weekly,
};

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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
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

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
      frequencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'frequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
      frequencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'frequency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
      frequencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frequency',
        value: '',
      ));
    });
  }

  QueryBuilder<TrackedFoodEntry, TrackedFoodEntry, QAfterFilterCondition>
      frequencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'frequency',
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
