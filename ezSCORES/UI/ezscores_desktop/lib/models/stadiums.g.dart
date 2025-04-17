// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stadiums.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stadiums _$StadiumsFromJson(Map<String, dynamic> json) => Stadiums()
  ..id = (json['id'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..picture = json['picture'] as String?;

Map<String, dynamic> _$StadiumsToJson(Stadiums instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picture': instance.picture,
    };
