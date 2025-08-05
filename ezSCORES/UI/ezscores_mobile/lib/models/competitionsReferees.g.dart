// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competitionsReferees.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompetitionsReferees _$CompetitionsRefereesFromJson(
        Map<String, dynamic> json) =>
    CompetitionsReferees()
      ..id = (json['id'] as num?)?.toInt()
      ..competitionId = (json['competitionId'] as num?)?.toInt()
      ..refereeId = (json['refereeId'] as num?)?.toInt()
      ..referee = json['referee'] == null
          ? null
          : Referees.fromJson(json['referee'] as Map<String, dynamic>);

Map<String, dynamic> _$CompetitionsRefereesToJson(
        CompetitionsReferees instance) =>
    <String, dynamic>{
      'id': instance.id,
      'competitionId': instance.competitionId,
      'refereeId': instance.refereeId,
      'referee': instance.referee,
    };
