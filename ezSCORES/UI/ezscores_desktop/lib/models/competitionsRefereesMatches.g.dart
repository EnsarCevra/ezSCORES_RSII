// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competitionsRefereesMatches.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompetitionsRefereesMatches _$CompetitionsRefereesMatchesFromJson(
        Map<String, dynamic> json) =>
    CompetitionsRefereesMatches()
      ..id = (json['id'] as num?)?.toInt()
      ..competitionsRefereesId =
          (json['competitionsRefereesId'] as num?)?.toInt()
      ..matchId = (json['matchId'] as num?)?.toInt()
      ..competitionReferee = json['competitionReferee'] == null
          ? null
          : CompetitionsReferees.fromJson(
              json['competitionReferee'] as Map<String, dynamic>);

Map<String, dynamic> _$CompetitionsRefereesMatchesToJson(
        CompetitionsRefereesMatches instance) =>
    <String, dynamic>{
      'id': instance.id,
      'competitionsRefereesId': instance.competitionsRefereesId,
      'matchId': instance.matchId,
      'competitionReferee': instance.competitionReferee,
    };
