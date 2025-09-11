import 'package:ezscores_mobile/models/competitionsTeams.dart';
import 'package:ezscores_mobile/models/selections.dart';
import 'package:ezscores_mobile/models/users.dart';
import 'package:json_annotation/json_annotation.dart';
part 'teams.g.dart';
@JsonSerializable()
class Teams{
  int? id;
  String? name;
  String? picture;
  Selections? selection;
  Users? user;
  CompetitionsTeams? competitionTeam;

  Teams({this.id, this.name});

  factory Teams.fromJson(Map<String, dynamic> json) => _$TeamsFromJson(json);
  Map<String, dynamic> toJson() => _$TeamsToJson(this);
}