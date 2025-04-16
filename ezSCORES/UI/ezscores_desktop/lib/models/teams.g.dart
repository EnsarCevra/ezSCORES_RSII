// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teams.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teams _$TeamsFromJson(Map<String, dynamic> json) => Teams(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    )
      ..picture = json['picture'] as String?
      ..selectionId = (json['selectionId'] as num?)?.toInt();

Map<String, dynamic> _$TeamsToJson(Teams instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picture': instance.picture,
      'selectionId': instance.selectionId,
    };
