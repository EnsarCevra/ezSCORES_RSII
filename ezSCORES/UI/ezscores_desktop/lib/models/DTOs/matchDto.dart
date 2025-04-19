import 'package:ezscores_desktop/models/DTOs/goalDto.dart';
import 'package:ezscores_desktop/models/DTOs/teamDto.dart';
import 'package:ezscores_desktop/models/enums/gameStage.dart';
import 'package:json_annotation/json_annotation.dart';

part 'matchDto.g.dart';

@JsonSerializable()
class MatchDTO {
	int? matchId;
	int? homeTeamScore;
	int? awayTeamScore;
	DateTime? dateAndTime;
  TeamDTO? homeTeam;
  TeamDTO? awayTeam;
	String? stadium;
  List<GoalDTO>? goals;
	List<String>? referees;
	int? fixtureId;
	String? group;
	int? fixtureSequenceNumber;
  GameStage? gameStage;
	bool? isUnderway;
	bool? isCompleted;

	MatchDTO();

	factory MatchDTO.fromJson(Map<String, dynamic> json) => _$MatchDTOFromJson(json);

	Map<String, dynamic> toJson() => _$MatchDTOToJson(this);
}