enum CompetitionStatus {
  initial,
  preparation,
  applicationsOpen,
  applicationsClosed,
  underway,
  finished,
}

extension CompetitionStatusExtension on CompetitionStatus {
  int get value {
    switch (this) {
      case CompetitionStatus.initial:
        return 0;
      case CompetitionStatus.preparation:
        return 1;
      case CompetitionStatus.applicationsOpen:
        return 2;
      case CompetitionStatus.applicationsClosed:
        return 3;
      case CompetitionStatus.underway:
        return 4;
      case CompetitionStatus.finished:
        return 5;
    }
  }

  String get displayName {
    switch (this) {
      case CompetitionStatus.initial:
        return 'Kreiranje';
      case CompetitionStatus.preparation:
        return 'Priprema';
      case CompetitionStatus.applicationsOpen:
        return 'Prijave otvorene';
      case CompetitionStatus.applicationsClosed:
        return 'Prijave zatvorene';
      case CompetitionStatus.underway:
        return 'U toku';
      case CompetitionStatus.finished:
        return 'Završeno';
    }
  }

  static CompetitionStatus? fromValue(int value) {
    return CompetitionStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => CompetitionStatus.initial,
    );
  }
}
