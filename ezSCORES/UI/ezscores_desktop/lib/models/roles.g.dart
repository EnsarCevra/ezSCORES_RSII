// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Roles _$RolesFromJson(Map<String, dynamic> json) => Roles()
  ..id = (json['id'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..description = json['description'] as String?;

Map<String, dynamic> _$RolesToJson(Roles instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
