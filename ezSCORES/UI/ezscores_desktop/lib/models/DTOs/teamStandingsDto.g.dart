// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teamStandingsDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamStandingsDTO _$TeamStandingsDTOFromJson(Map<String, dynamic> json) =>
    TeamStandingsDTO()
      ..competitionTeamId = (json['competitionTeamId'] as num?)?.toInt()
      ..teamName = json['teamName'] as String?
      ..played = (json['played'] as num?)?.toInt()
      ..wins = (json['wins'] as num?)?.toInt()
      ..draws = (json['draws'] as num?)?.toInt()
      ..losses = (json['losses'] as num?)?.toInt()
      ..goalsScored = (json['goalsScored'] as num?)?.toInt()
      ..goalsConceded = (json['goalsConceded'] as num?)?.toInt()
      ..points = (json['points'] as num?)?.toInt()
      ..goalDifference = (json['goalDifference'] as num?)?.toInt();

Map<String, dynamic> _$TeamStandingsDTOToJson(TeamStandingsDTO instance) =>
    <String, dynamic>{
      'competitionTeamId': instance.competitionTeamId,
      'teamName': instance.teamName,
      'played': instance.played,
      'wins': instance.wins,
      'draws': instance.draws,
      'losses': instance.losses,
      'goalsScored': instance.goalsScored,
      'goalsConceded': instance.goalsConceded,
      'points': instance.points,
      'goalDifference': instance.goalDifference,
    };
