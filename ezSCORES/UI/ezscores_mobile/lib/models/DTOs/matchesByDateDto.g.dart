// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matchesByDateDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchesByDateDTO _$MatchesByDateDTOFromJson(Map<String, dynamic> json) =>
    MatchesByDateDTO(
      json['competition'] == null
          ? null
          : Competitions.fromJson(json['competition'] as Map<String, dynamic>),
      (json['matches'] as List<dynamic>?)
          ?.map((e) => MatchDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MatchesByDateDTOToJson(MatchesByDateDTO instance) =>
    <String, dynamic>{
      'competition': instance.competition,
      'matches': instance.matches,
    };
