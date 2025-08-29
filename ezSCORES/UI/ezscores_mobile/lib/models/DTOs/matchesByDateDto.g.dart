// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matchesByDateDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchesByDateDTO _$MatchesByDateDTOFromJson(Map<String, dynamic> json) =>
    MatchesByDateDTO(
      (json['competitionId'] as num?)?.toInt(),
      json['competitionName'] as String?,
      (json['matches'] as List<dynamic>?)
          ?.map((e) => MatchDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MatchesByDateDTOToJson(MatchesByDateDTO instance) =>
    <String, dynamic>{
      'competitionId': instance.competitionId,
      'competitionName': instance.competitionName,
      'matches': instance.matches,
    };
