import 'package:json_annotation/json_annotation.dart';

part 'players.g.dart';

@JsonSerializable()
class Players {
	int? id;
	String? firstName;
	String? lastName;
	String? picture;
	DateTime? birthDate;

	Players();

	factory Players.fromJson(Map<String, dynamic> json) => _$PlayersFromJson(json);

	Map<String, dynamic> toJson() => _$PlayersToJson(this);
}