enum GameStage {
  groupPhase,
  roundOf16,
  quarterFinals,
  semiFinals,
  thirdPlace,
  finals,
  league,
}

extension GameStageExtension on GameStage {
  int get value {
    switch (this) {
      case GameStage.groupPhase:
        return 0;
      case GameStage.roundOf16:
        return 1;
      case GameStage.quarterFinals:
        return 2;
      case GameStage.semiFinals:
        return 3;
      case GameStage.thirdPlace:
        return 4;
      case GameStage.finals:
        return 5;
      case GameStage.league:
        return 6;
    }
  }

  String get displayName {
    switch (this) {
      case GameStage.groupPhase:
        return 'Grupna faza';
      case GameStage.roundOf16:
        return 'Osmina finala';
      case GameStage.quarterFinals:
        return 'Četvrtina finala';
      case GameStage.semiFinals:
        return 'Polufinale';
      case GameStage.thirdPlace:
        return 'Utakmica za 3. mjesto';
      case GameStage.finals:
        return 'Finale';
      case GameStage.league:
        return 'Liga';
    }
  }

  static GameStage? fromValue(int value) {
    return GameStage.values.firstWhere(
      (e) => e.value == value,
      orElse: () => GameStage.groupPhase,
    );
  }
}
