import 'package:json_annotation/json_annotation.dart';

part 'teamStandingsDto.g.dart';

@JsonSerializable()
class TeamStandingsDTO {
	int? competitionTeamId;
	String? teamName;
	int? played;
	int? wins;
	int? draws;
	int? losses;
	int? goalsScored;
	int? goalsConceded;
	int? points;
	int? goalDifference;

	TeamStandingsDTO();

	factory TeamStandingsDTO.fromJson(Map<String, dynamic> json) => _$TeamStandingsDTOFromJson(json);

	Map<String, dynamic> toJson() => _$TeamStandingsDTOToJson(this);
}