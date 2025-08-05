// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competitionsTeams.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompetitionsTeams _$CompetitionsTeamsFromJson(Map<String, dynamic> json) =>
    CompetitionsTeams()
      ..id = (json['id'] as num?)?.toInt()
      ..competitionId = (json['competitionId'] as num?)?.toInt()
      ..teamId = (json['teamId'] as num?)?.toInt()
      ..groupId = (json['groupId'] as num?)?.toInt()
      ..isEliminated = json['isEliminated'] as bool?
      ..team = json['team'] == null
          ? null
          : Teams.fromJson(json['team'] as Map<String, dynamic>)
      ..competitionsTeamsPlayers =
          (json['competitionsTeamsPlayers'] as List<dynamic>?)
              ?.map((e) =>
                  CompetitionsTeamsPlayers.fromJson(e as Map<String, dynamic>))
              .toList();

Map<String, dynamic> _$CompetitionsTeamsToJson(CompetitionsTeams instance) =>
    <String, dynamic>{
      'id': instance.id,
      'competitionId': instance.competitionId,
      'teamId': instance.teamId,
      'groupId': instance.groupId,
      'isEliminated': instance.isEliminated,
      'team': instance.team,
      'competitionsTeamsPlayers': instance.competitionsTeamsPlayers,
    };
