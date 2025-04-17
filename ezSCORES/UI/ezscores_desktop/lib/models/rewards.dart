import 'package:json_annotation/json_annotation.dart';

part 'rewards.g.dart';

@JsonSerializable()
class Rewards {
	int? id;
	int? competitionId;
	String? name;
	int? rankingPosition;
	int? amount;
	String? description;

	Rewards();

	factory Rewards.fromJson(Map<String, dynamic> json) => _$RewardsFromJson(json);

	Map<String, dynamic> toJson() => _$RewardsToJson(this);
}
