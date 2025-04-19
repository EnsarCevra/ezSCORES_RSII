// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teamDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamDTO _$TeamDTOFromJson(Map<String, dynamic> json) => TeamDTO()
  ..id = (json['id'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..players = (json['players'] as List<dynamic>?)
      ?.map((e) => PlayerDTO.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$TeamDTOToJson(TeamDTO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'players': instance.players?.map((e) => e.toJson()).toList(),
    };
