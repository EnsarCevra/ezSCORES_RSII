// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groups.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Groups _$GroupsFromJson(Map<String, dynamic> json) => Groups()
  ..id = (json['id'] as num?)?.toInt()
  ..competitionId = (json['competitionId'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..competitionsTeams = (json['competitionsTeams'] as List<dynamic>?)
      ?.map((e) => CompetitionsTeams.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$GroupsToJson(Groups instance) => <String, dynamic>{
      'id': instance.id,
      'competitionId': instance.competitionId,
      'name': instance.name,
      'competitionsTeams': instance.competitionsTeams,
    };
