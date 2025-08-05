// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goals.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goals _$GoalsFromJson(Map<String, dynamic> json) => Goals()
  ..id = (json['id'] as num?)?.toInt()
  ..competitionTeamPlayerId = (json['competitionTeamPlayerId'] as num?)?.toInt()
  ..matchId = (json['matchId'] as num?)?.toInt()
  ..sequenceNumber = (json['sequenceNumber'] as num?)?.toInt()
  ..scoredAtMinute = (json['scoredAtMinute'] as num?)?.toInt()
  ..isHomeGoal = json['isHomeGoal'] as bool?
  ..competitionsTeamsPlayers = json['competitionsTeamsPlayers'] == null
      ? null
      : CompetitionsTeamsPlayers.fromJson(
          json['competitionsTeamsPlayers'] as Map<String, dynamic>);

Map<String, dynamic> _$GoalsToJson(Goals instance) => <String, dynamic>{
      'id': instance.id,
      'competitionTeamPlayerId': instance.competitionTeamPlayerId,
      'matchId': instance.matchId,
      'sequenceNumber': instance.sequenceNumber,
      'scoredAtMinute': instance.scoredAtMinute,
      'isHomeGoal': instance.isHomeGoal,
      'competitionsTeamsPlayers': instance.competitionsTeamsPlayers,
    };
