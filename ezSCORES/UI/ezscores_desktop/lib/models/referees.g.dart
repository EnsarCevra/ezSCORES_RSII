// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'referees.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Referees _$RefereesFromJson(Map<String, dynamic> json) => Referees()
  ..id = (json['id'] as num?)?.toInt()
  ..firstName = json['firstName'] as String?
  ..lastName = json['lastName'] as String?
  ..picture = json['picture'] as String?;

Map<String, dynamic> _$RefereesToJson(Referees instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'picture': instance.picture,
    };
