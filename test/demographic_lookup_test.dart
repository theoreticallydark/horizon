import 'package:flutter_test/flutter_test.dart';
import 'package:horizon/data/utils/demographic_lookup.dart';

void main() {
  group('DemographicLookup Tests', () {
    final sampleDriList = [
      {
        'demographics': {
          'sex': 'both',
          'age_range': '1-3 y',
          'is_pregnant': false,
          'is_lactating': false,
        },
        'nutrients': {'vitamin_c': {'rda_or_ai': 15.0}}
      },
      {
        'demographics': {
          'sex': 'male',
          'age_range': '19-30 y',
          'is_pregnant': false,
          'is_lactating': false,
        },
        'nutrients': {'vitamin_c': {'rda_or_ai': 90.0}}
      },
      {
        'demographics': {
          'sex': 'female',
          'age_range': '19-30 y',
          'is_pregnant': false,
          'is_lactating': false,
        },
        'nutrients': {'vitamin_c': {'rda_or_ai': 75.0}}
      },
      {
        'demographics': {
          'sex': 'female',
          'age_range': '19-30 y',
          'is_pregnant': true,
          'is_lactating': false,
        },
        'nutrients': {'vitamin_c': {'rda_or_ai': 85.0}}
      },
    ];

    test('Matches 25-year-old male accurately', () {
      final match = DemographicLookup.findDemographicMatch(
        driDataList: sampleDriList,
        ageInYears: 25,
        sex: 'male',
        isPregnant: false,
        isLactating: false,
      );

      expect(match, isNotNull);
      final rda = match!['nutrients']['vitamin_c']['rda_or_ai'];
      expect(rda, 90.0);
    });

    test('Matches 25-year-old pregnant female accurately', () {
      final match = DemographicLookup.findDemographicMatch(
        driDataList: sampleDriList,
        ageInYears: 25,
        sex: 'female',
        isPregnant: true,
        isLactating: false,
      );

      expect(match, isNotNull);
      final rda = match!['nutrients']['vitamin_c']['rda_or_ai'];
      expect(rda, 85.0);
    });
  });
}
