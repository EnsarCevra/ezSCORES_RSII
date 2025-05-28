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
  ..gameStage =
      const GameStageConverter().fromJson((json['gameStage'] as num?)?.toInt())
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
      'gameStage': const GameStageConverter().toJson(instance.gameStage),
      'matches': instance.matches,
    };
