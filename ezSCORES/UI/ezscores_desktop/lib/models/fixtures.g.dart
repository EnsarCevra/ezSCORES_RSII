// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fixtures.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fixtures _$FixturesFromJson(Map<String, dynamic> json) => Fixtures()
  ..id = (json['id'] as num?)?.toInt()
  ..competitionId = (json['competitionId'] as num?)?.toInt()
  ..sequenceNumber = (json['sequenceNumber'] as num?)?.toInt()
  ..matchLength = (json['matchLength'] as num?)?.toInt()
  ..isCurrentlyActive = json['isCurrentlyActive'] as bool?
  ..isCompleted = json['isCompleted'] as bool?
  ..gameStage = $enumDecodeNullable(_$GameStageEnumMap, json['gameStage'])
  ..matches = (json['matches'] as List<dynamic>?)
      ?.map((e) => Matches.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$FixturesToJson(Fixtures instance) => <String, dynamic>{
      'id': instance.id,
      'competitionId': instance.competitionId,
      'sequenceNumber': instance.sequenceNumber,
      'matchLength': instance.matchLength,
      'isCurrentlyActive': instance.isCurrentlyActive,
      'isCompleted': instance.isCompleted,
      'gameStage': _$GameStageEnumMap[instance.gameStage],
      'matches': instance.matches,
    };

const _$GameStageEnumMap = {
  GameStage.groupPhase: 'groupPhase',
  GameStage.roundOf16: 'roundOf16',
  GameStage.quarterFinals: 'quarterFinals',
  GameStage.semiFinals: 'semiFinals',
  GameStage.thirdPlace: 'thirdPlace',
  GameStage.finals: 'finals',
  GameStage.league: 'league',
};
