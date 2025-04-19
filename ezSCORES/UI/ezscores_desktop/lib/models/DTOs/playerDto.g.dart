// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playerDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerDTO _$PlayerDTOFromJson(Map<String, dynamic> json) => PlayerDTO()
  ..id = (json['id'] as num?)?.toInt()
  ..name = json['name'] as String?;

Map<String, dynamic> _$PlayerDTOToJson(PlayerDTO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
