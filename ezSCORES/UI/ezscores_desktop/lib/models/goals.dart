import 'package:json_annotation/json_annotation.dart';
import 'competitionsTeamsPlayers.dart';

part 'goals.g.dart';

@JsonSerializable()
class Goals {
	int? id;
	int? competitionTeamPlayerId;
	int? matchId;
	int? sequenceNumber;
	int? scoredAtMinute;
	bool? isHomeGoal;
	CompetitionsTeamsPlayers? competitionsTeamsPlayers;

	Goals();

	factory Goals.fromJson(Map<String, dynamic> json) => _$GoalsFromJson(json);

	Map<String, dynamic> toJson() => _$GoalsToJson(this);
}