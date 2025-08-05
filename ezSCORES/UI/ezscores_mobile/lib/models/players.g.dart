// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'players.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Players _$PlayersFromJson(Map<String, dynamic> json) => Players()
  ..id = (json['id'] as num?)?.toInt()
  ..firstName = json['firstName'] as String?
  ..lastName = json['lastName'] as String?
  ..picture = json['picture'] as String?
  ..birthDate = json['birthDate'] == null
      ? null
      : DateTime.parse(json['birthDate'] as String);

Map<String, dynamic> _$PlayersToJson(Players instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'picture': instance.picture,
      'birthDate': instance.birthDate?.toIso8601String(),
    };
