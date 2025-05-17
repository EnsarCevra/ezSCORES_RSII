import 'package:ezscores_desktop/models/selections.dart';
import 'package:ezscores_desktop/models/users.dart';
import 'package:json_annotation/json_annotation.dart';
part 'teams.g.dart';
@JsonSerializable()
class Teams{
  int? id;
  String? name;
  String? picture;
  Selections? selection;
  Users? user;

  Teams({this.id, this.name});

  factory Teams.fromJson(Map<String, dynamic> json) => _$TeamsFromJson(json);
  Map<String, dynamic> toJson() => _$TeamsToJson(this);
}