enum CompetitionType {
  tournamentKnockOutOnly,
  tournament,
  league,
}

extension CompetitionTypeExtension on CompetitionType {
  int get value {
    switch (this) {
      case CompetitionType.tournamentKnockOutOnly:
        return 0;
      case CompetitionType.tournament:
        return 1;
      case CompetitionType.league:
        return 2;
    }
  }

  String get displayName {
    switch (this) {
      case CompetitionType.tournamentKnockOutOnly:
        return 'Samo KnockOut';
      case CompetitionType.tournament:
        return 'Grupna faza + KO';
      case CompetitionType.league:
        return 'Liga';
    }
  }

  static CompetitionType? fromInt(int value) {
    switch (value) {
      case 0:
        return CompetitionType.tournamentKnockOutOnly;
      case 1:
        return CompetitionType.tournament;
      case 2:
        return CompetitionType.league;
      default:
        return null;
    }
  }

  static CompetitionType? fromValue(int value) {
    return CompetitionType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => CompetitionType.tournamentKnockOutOnly,
    );
  }
}
