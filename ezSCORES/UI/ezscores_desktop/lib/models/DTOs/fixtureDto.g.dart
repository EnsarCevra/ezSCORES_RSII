// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fixtureDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FixtureDTO _$FixtureDTOFromJson(Map<String, dynamic> json) => FixtureDTO(
      (json['id'] as num?)?.toInt(),
      (json['sequenceNumber'] as num?)?.toInt(),
      json['isCurrentlyActive'] as bool?,
      json['isCompleted'] as bool?,
    )..gameStage = $enumDecodeNullable(_$GameStageEnumMap, json['gameStage']);

Map<String, dynamic> _$FixtureDTOToJson(FixtureDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gameStage': _$GameStageEnumMap[instance.gameStage],
      'sequenceNumber': instance.sequenceNumber,
      'isCurrentlyActive': instance.isCurrentlyActive,
      'isCompleted': instance.isCompleted,
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
