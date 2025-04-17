// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competitionsSponsors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompetitionsSponsors _$CompetitionsSponsorsFromJson(
        Map<String, dynamic> json) =>
    CompetitionsSponsors()
      ..id = (json['id'] as num?)?.toInt()
      ..competitionId = (json['competitionId'] as num?)?.toInt()
      ..sponsorId = (json['sponsorId'] as num?)?.toInt()
      ..type = (json['type'] as num?)?.toInt();

Map<String, dynamic> _$CompetitionsSponsorsToJson(
        CompetitionsSponsors instance) =>
    <String, dynamic>{
      'id': instance.id,
      'competitionId': instance.competitionId,
      'sponsorId': instance.sponsorId,
      'type': instance.type,
    };
