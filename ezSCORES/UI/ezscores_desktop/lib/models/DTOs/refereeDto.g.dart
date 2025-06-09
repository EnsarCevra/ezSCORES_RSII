// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refereeDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefereeDTO _$RefereeDTOFromJson(Map<String, dynamic> json) => RefereeDTO()
  ..id = (json['id'] as num?)?.toInt()
  ..competitionRefereeId = (json['competitionRefereeId'] as num?)?.toInt()
  ..name = json['name'] as String?;

Map<String, dynamic> _$RefereeDTOToJson(RefereeDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'competitionRefereeId': instance.competitionRefereeId,
      'name': instance.name,
    };
