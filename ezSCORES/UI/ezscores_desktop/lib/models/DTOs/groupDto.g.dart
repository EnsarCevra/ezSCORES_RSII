// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groupDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupDTO _$GroupDTOFromJson(Map<String, dynamic> json) => GroupDTO()
  ..id = (json['id'] as num?)?.toInt()
  ..name = json['name'] as String?;

Map<String, dynamic> _$GroupDTOToJson(GroupDTO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
