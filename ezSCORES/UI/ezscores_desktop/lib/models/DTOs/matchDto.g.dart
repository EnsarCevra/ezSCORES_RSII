// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matchDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchDTO _$MatchDTOFromJson(Map<String, dynamic> json) => MatchDTO()
  ..matchId = (json['matchId'] as num?)?.toInt()
  ..homeTeamScore = (json['homeTeamScore'] as num?)?.toInt()
  ..awayTeamScore = (json['awayTeamScore'] as num?)?.toInt()
  ..dateAndTime = json['dateAndTime'] == null
      ? null
      : DateTime.parse(json['dateAndTime'] as String)
  ..homeTeam = json['homeTeam'] == null
      ? null
      : TeamDTO.fromJson(json['homeTeam'] as Map<String, dynamic>)
  ..awayTeam = json['awayTeam'] == null
      ? null
      : TeamDTO.fromJson(json['awayTeam'] as Map<String, dynamic>)
  ..stadium = json['stadium'] == null
      ? null
      : Stadiums.fromJson(json['stadium'] as Map<String, dynamic>)
  ..goals = (json['goals'] as List<dynamic>?)
      ?.map((e) => GoalDTO.fromJson(e as Map<String, dynamic>))
      .toList()
  ..referees = (json['referees'] as List<dynamic>?)
      ?.map((e) => RefereeDTO.fromJson(e as Map<String, dynamic>))
      .toList()
  ..fixtureId = (json['fixtureId'] as num?)?.toInt()
  ..group = json['group'] == null
      ? null
      : GroupDTO.fromJson(json['group'] as Map<String, dynamic>)
  ..fixtureSequenceNumber = (json['fixtureSequenceNumber'] as num?)?.toInt()
  ..gameStage =
      const GameStageConverter().fromJson((json['gameStage'] as num?)?.toInt())
  ..isUnderway = json['isUnderway'] as bool?
  ..isCompleted = json['isCompleted'] as bool?;

Map<String, dynamic> _$MatchDTOToJson(MatchDTO instance) => <String, dynamic>{
      'matchId': instance.matchId,
      'homeTeamScore': instance.homeTeamScore,
      'awayTeamScore': instance.awayTeamScore,
      'dateAndTime': instance.dateAndTime?.toIso8601String(),
      'homeTeam': instance.homeTeam,
      'awayTeam': instance.awayTeam,
      'stadium': instance.stadium,
      'goals': instance.goals,
      'referees': instance.referees,
      'fixtureId': instance.fixtureId,
      'group': instance.group,
      'fixtureSequenceNumber': instance.fixtureSequenceNumber,
      'gameStage': const GameStageConverter().toJson(instance.gameStage),
      'isUnderway': instance.isUnderway,
      'isCompleted': instance.isCompleted,
    };
