import 'package:ezscores_mobile/models/competitionsReferees.dart';
import 'package:json_annotation/json_annotation.dart';

part 'competitionsRefereesMatches.g.dart';

@JsonSerializable()
class CompetitionsRefereesMatches {
	int? id;
	int? competitionsRefereesId;
	int? matchId;
	CompetitionsReferees? competitionReferee;

	CompetitionsRefereesMatches();

	factory CompetitionsRefereesMatches.fromJson(Map<String, dynamic> json) => _$CompetitionsRefereesMatchesFromJson(json);

	Map<String, dynamic> toJson() => _$CompetitionsRefereesMatchesToJson(this);
}