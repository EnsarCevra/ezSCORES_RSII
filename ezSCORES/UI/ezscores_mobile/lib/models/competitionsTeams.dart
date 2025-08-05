import 'package:ezscores_mobile/models/competitionsTeamsPlayers.dart';
import 'package:ezscores_mobile/models/teams.dart';
import 'package:json_annotation/json_annotation.dart';

part 'competitionsTeams.g.dart';

@JsonSerializable()
class CompetitionsTeams {
	int? id;
	int? competitionId;
	int? teamId;
	int? groupId;
	bool? isEliminated;
  Teams? team;
	List<CompetitionsTeamsPlayers>? competitionsTeamsPlayers;

	CompetitionsTeams();

	factory CompetitionsTeams.fromJson(Map<String, dynamic> json) => _$CompetitionsTeamsFromJson(json);

	Map<String, dynamic> toJson() => _$CompetitionsTeamsToJson(this);
}
