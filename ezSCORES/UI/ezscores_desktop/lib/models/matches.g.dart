// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matches.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Matches _$MatchesFromJson(Map<String, dynamic> json) => Matches()
  ..id = (json['id'] as num?)?.toInt()
  ..fixtureId = (json['fixtureId'] as num?)?.toInt()
  ..homeTeamId = (json['homeTeamId'] as num?)?.toInt()
  ..awayTeamId = (json['awayTeamId'] as num?)?.toInt()
  ..stadiumId = (json['stadiumId'] as num?)?.toInt()
  ..winnerId = (json['winnerId'] as num?)?.toInt()
  ..dateAndTime = json['dateAndTime'] == null
      ? null
      : DateTime.parse(json['dateAndTime'] as String)
  ..isCompleted = json['isCompleted'] as bool?
  ..isCompletedInRegullarTime = json['isCompletedInRegullarTime'] as bool?
  ..isUnderway = json['isUnderway'] as bool?
  ..homeTeam = json['homeTeam'] == null
      ? null
      : CompetitionsTeams.fromJson(json['homeTeam'] as Map<String, dynamic>)
  ..awayTeam = json['awayTeam'] == null
      ? null
      : CompetitionsTeams.fromJson(json['awayTeam'] as Map<String, dynamic>)
  ..competitionsRefereesMatches =
      (json['competitionsRefereesMatches'] as List<dynamic>?)
          ?.map((e) =>
              CompetitionsRefereesMatches.fromJson(e as Map<String, dynamic>))
          .toList()
  ..goals = (json['goals'] as List<dynamic>?)
      ?.map((e) => Goals.fromJson(e as Map<String, dynamic>))
      .toList()
  ..stadium = json['stadium'] == null
      ? null
      : Stadiums.fromJson(json['stadium'] as Map<String, dynamic>);

Map<String, dynamic> _$MatchesToJson(Matches instance) => <String, dynamic>{
      'id': instance.id,
      'fixtureId': instance.fixtureId,
      'homeTeamId': instance.homeTeamId,
      'awayTeamId': instance.awayTeamId,
      'stadiumId': instance.stadiumId,
      'winnerId': instance.winnerId,
      'dateAndTime': instance.dateAndTime?.toIso8601String(),
      'isCompleted': instance.isCompleted,
      'isCompletedInRegullarTime': instance.isCompletedInRegullarTime,
      'isUnderway': instance.isUnderway,
      'homeTeam': instance.homeTeam,
      'awayTeam': instance.awayTeam,
      'competitionsRefereesMatches': instance.competitionsRefereesMatches,
      'goals': instance.goals,
      'stadium': instance.stadium,
    };
