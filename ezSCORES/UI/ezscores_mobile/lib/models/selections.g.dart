// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selections.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Selections _$SelectionsFromJson(Map<String, dynamic> json) => Selections(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      ageMax: (json['ageMax'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SelectionsToJson(Selections instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ageMax': instance.ageMax,
    };
