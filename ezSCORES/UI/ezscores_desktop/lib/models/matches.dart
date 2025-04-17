import 'package:ezscores_desktop/models/competitionsRefereesMatches.dart';
import 'package:ezscores_desktop/models/competitionsTeams.dart';
import 'package:ezscores_desktop/models/goals.dart';
import 'package:ezscores_desktop/models/stadiums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'matches.g.dart';

@JsonSerializable()
class Matches {
	int? id;
	int? fixtureId;
	int? homeTeamId;
	int? awayTeamId;
	int? stadiumId;
	int? winnerId;
	DateTime? dateAndTime;
	bool? isCompleted;
	bool? isCompletedInRegullarTime;
	bool? isUnderway;
  CompetitionsTeams? homeTeam;
  CompetitionsTeams? awayTeam;
  List<CompetitionsRefereesMatches>? competitionsRefereesMatches;
  List<Goals>? goals;
  Stadiums? stadium;

	Matches();

	factory Matches.fromJson(Map<String, dynamic> json) => _$MatchesFromJson(json);

	Map<String, dynamic> toJson() => _$MatchesToJson(this);
}
