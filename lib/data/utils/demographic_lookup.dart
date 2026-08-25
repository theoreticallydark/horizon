class DemographicLookup {
  /// Matches the closest demographic profile from DRI data list.
  static Map<String, dynamic>? findDemographicMatch({
    required List<dynamic> driDataList,
    required int ageInYears,
    required String sex, // 'male' | 'female'
    required bool isPregnant,
    required bool isLactating,
  }) {
    for (final entry in driDataList) {
      final demo = entry['demographics'] as Map<String, dynamic>;
      final demoSex = demo['sex'] as String;
      final isPreg = demo['is_pregnant'] as bool? ?? false;
      final isLact = demo['is_lactating'] as bool? ?? false;
      final ageRange = demo['age_range'] as String;

      // Check pregnancy/lactation first
      if (isPregnant != isPreg) continue;
      if (isLactating != isLact) continue;

      // Check sex
      if (demoSex != 'both' && demoSex.toLowerCase() != sex.toLowerCase()) {
        continue;
      }

      // Check age range
      if (_matchesAgeRange(ageInYears, ageRange)) {
        return entry as Map<String, dynamic>;
      }
    }

    // Fallback: match 19-30 y for the sex if not found
    for (final entry in driDataList) {
      final demo = entry['demographics'] as Map<String, dynamic>;
      final demoSex = demo['sex'] as String;
      final ageRange = demo['age_range'] as String;
      if ((demoSex == 'both' || demoSex.toLowerCase() == sex.toLowerCase()) &&
          ageRange.contains('19-30')) {
        return entry as Map<String, dynamic>;
      }
    }

    return driDataList.isNotEmpty ? driDataList.first as Map<String, dynamic> : null;
  }

  static bool _matchesAgeRange(int ageYears, String ageRange) {
    // Examples: "0-6 mo", "7-12 mo", "1-3 y", "4-8 y", "9-13 y", "14-18 y", "19-30 y", "31-50 y", "51-70 y", "> 70 y"
    if (ageRange.contains('mo')) {
      return ageYears == 0;
    }
    if (ageRange.startsWith('>')) {
      final minAgeStr = ageRange.replaceAll(RegExp(r'[^\d]'), '');
      final minAge = int.tryParse(minAgeStr) ?? 70;
      return ageYears > minAge;
    }
    if (ageRange.contains('-')) {
      final parts = ageRange.split('-');
      final minStr = parts[0].replaceAll(RegExp(r'[^\d]'), '');
      final maxStr = parts[1].replaceAll(RegExp(r'[^\d]'), '');
      final minAge = int.tryParse(minStr) ?? 0;
      final maxAge = int.tryParse(maxStr) ?? 150;
      return ageYears >= minAge && ageYears <= maxAge;
    }
    return false;
  }
}
