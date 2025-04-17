// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sponsors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sponsors _$SponsorsFromJson(Map<String, dynamic> json) => Sponsors()
  ..id = (json['id'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..picture = json['picture'] as String?;

Map<String, dynamic> _$SponsorsToJson(Sponsors instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picture': instance.picture,
    };
