import 'package:ezscores_mobile/models/roles.dart';
import 'package:json_annotation/json_annotation.dart';
part 'users.g.dart';
@JsonSerializable()
class Users{
  int? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? picture;
  String? email;
  String? phoneNumber;
  String? organization;
  Roles? role;

  Users({
    this.id,
    this.firstName,
    this.lastName,
    this.userName,
    this.picture,
    this.email,
    this.phoneNumber,
    this.organization,
    this.role,
  });

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);
  Map<String, dynamic> toJson() => _$UsersToJson(this);
}