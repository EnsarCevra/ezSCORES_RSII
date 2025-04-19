// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groupStandingsDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupStandingsDTO _$GroupStandingsDTOFromJson(Map<String, dynamic> json) =>
    GroupStandingsDTO()
      ..groupId = (json['groupId'] as num?)?.toInt()
      ..groupName = json['groupName'] as String?
      ..standings = (json['standings'] as List<dynamic>?)
          ?.map((e) => TeamStandingsDTO.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$GroupStandingsDTOToJson(GroupStandingsDTO instance) =>
    <String, dynamic>{
      'groupId': instance.groupId,
      'groupName': instance.groupName,
      'standings': instance.standings?.map((e) => e.toJson()).toList(),
    };
