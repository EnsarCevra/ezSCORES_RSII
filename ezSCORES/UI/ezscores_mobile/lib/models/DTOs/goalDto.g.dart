// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goalDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoalDTO _$GoalDTOFromJson(Map<String, dynamic> json) => GoalDTO(
      (json['id'] as num?)?.toInt(),
      json['scorer'] as String?,
      (json['scoredAtMinute'] as num?)?.toInt(),
      json['isHomeGoal'] as bool?,
      (json['sequenceNumber'] as num?)?.toInt(),
    )..competitionTeamPlayerId =
        (json['competitionTeamPlayerId'] as num?)?.toInt();

Map<String, dynamic> _$GoalDTOToJson(GoalDTO instance) => <String, dynamic>{
      'id': instance.id,
      'competitionTeamPlayerId': instance.competitionTeamPlayerId,
      'scorer': instance.scorer,
      'scoredAtMinute': instance.scoredAtMinute,
      'isHomeGoal': instance.isHomeGoal,
      'sequenceNumber': instance.sequenceNumber,
    };
