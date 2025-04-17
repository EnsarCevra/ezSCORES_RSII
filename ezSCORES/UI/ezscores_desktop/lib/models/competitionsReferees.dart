// -- competitions_referees.dart --
import 'package:ezscores_desktop/models/referees.dart';
import 'package:json_annotation/json_annotation.dart';

part 'competitionsReferees.g.dart';

@JsonSerializable()
class CompetitionsReferees {
	int? id;
	int? competitionId;
	int? refereeId;
  Referees? referee;

	CompetitionsReferees();

	factory CompetitionsReferees.fromJson(Map<String, dynamic> json) => _$CompetitionsRefereesFromJson(json);

	Map<String, dynamic> toJson() => _$CompetitionsRefereesToJson(this);
}
