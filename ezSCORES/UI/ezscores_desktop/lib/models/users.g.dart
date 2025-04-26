// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) => Users()
  ..id = (json['id'] as num?)?.toInt()
  ..firstName = json['firstName'] as String?
  ..lastName = json['lastName'] as String?
  ..userName = json['userName'] as String?
  ..picture = json['picture'] as String?
  ..email = json['email'] as String?
  ..phoneNumber = json['phoneNumber'] as String?
  ..organization = json['organization'] as String?
  ..role = json['role'] == null
      ? null
      : Roles.fromJson(json['role'] as Map<String, dynamic>);

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'userName': instance.userName,
      'picture': instance.picture,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'organization': instance.organization,
      'role': instance.role,
    };
