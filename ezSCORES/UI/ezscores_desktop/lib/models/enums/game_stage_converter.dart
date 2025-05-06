import 'package:ezscores_desktop/models/enums/gameStage.dart';
import 'package:json_annotation/json_annotation.dart';

class GameStageConverter implements JsonConverter<GameStage?, int?> {
  const GameStageConverter();

  @override
  GameStage? fromJson(int? json) {
    if (json == null) return null;
    return GameStageExtension.fromValue(json);
  }

  @override
  int? toJson(GameStage? object) {
    return object?.value;
  }
}
