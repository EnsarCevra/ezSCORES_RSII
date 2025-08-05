import 'package:ezscores_mobile/models/players.dart';
import 'package:json_annotation/json_annotation.dart';

part 'competitionsTeamsPlayers.g.dart';

@JsonSerializable()
class CompetitionsTeamsPlayers {
	int? id;
	int? competitionsTeamsId;
	int? playerId;
	int? goalsTotal;
	bool? isVerified;
  Players? player;

	CompetitionsTeamsPlayers();

	factory CompetitionsTeamsPlayers.fromJson(Map<String, dynamic> json) => _$CompetitionsTeamsPlayersFromJson(json);

	Map<String, dynamic> toJson() => _$CompetitionsTeamsPlayersToJson(this);
}
