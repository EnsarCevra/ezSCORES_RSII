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
    )
      ..gameStage = const GameStageConverter()
          .fromJson((json['gameStage'] as num?)?.toInt())
      ..matches = (json['matches'] as List<dynamic>?)
          ?.map((e) => MatchDTO.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$FixtureDTOToJson(FixtureDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gameStage': const GameStageConverter().toJson(instance.gameStage),
      'sequenceNumber': instance.sequenceNumber,
      'isCurrentlyActive': instance.isCurrentlyActive,
      'isCompleted': instance.isCompleted,
      'matches': instance.matches,
    };
