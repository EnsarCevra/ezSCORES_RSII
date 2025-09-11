// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teams.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teams _$TeamsFromJson(Map<String, dynamic> json) => Teams(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    )
      ..picture = json['picture'] as String?
      ..selection = json['selection'] == null
          ? null
          : Selections.fromJson(json['selection'] as Map<String, dynamic>)
      ..user = json['user'] == null
          ? null
          : Users.fromJson(json['user'] as Map<String, dynamic>)
      ..competitionTeam = json['competitionTeam'] == null
          ? null
          : CompetitionsTeams.fromJson(
              json['competitionTeam'] as Map<String, dynamic>);

Map<String, dynamic> _$TeamsToJson(Teams instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picture': instance.picture,
      'selection': instance.selection,
      'user': instance.user,
      'competitionTeam': instance.competitionTeam,
    };
