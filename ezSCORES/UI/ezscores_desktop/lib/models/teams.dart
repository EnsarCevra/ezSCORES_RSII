import 'package:json_annotation/json_annotation.dart';
part 'teams.g.dart';
@JsonSerializable()
class Teams{
  int? id;
  String? name;
  String? picture;
  int? selectionId;


  Teams({this.id, this.name});

  factory Teams.fromJson(Map<String, dynamic> json) => _$TeamsFromJson(json);
  Map<String, dynamic> toJson() => _$TeamsToJson(this);
}