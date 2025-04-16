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
  String? orzanization;

  Users();

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);
  Map<String, dynamic> toJson() => _$UsersToJson(this);
}