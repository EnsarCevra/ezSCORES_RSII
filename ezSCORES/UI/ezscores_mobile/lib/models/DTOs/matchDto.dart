import 'package:ezscores_mobile/models/DTOs/goalDto.dart';
import 'package:ezscores_mobile/models/DTOs/groupDto.dart';
import 'package:ezscores_mobile/models/DTOs/refereeDto.dart';
import 'package:ezscores_mobile/models/DTOs/teamDto.dart';
import 'package:ezscores_mobile/models/enums/gameStage.dart';
import 'package:ezscores_mobile/models/enums/game_stage_converter.dart';
import 'package:ezscores_mobile/models/stadiums.dart';
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
	Stadiums? stadium;
  List<GoalDTO>? goals;
	List<RefereeDTO>? referees;
	int? fixtureId;
	GroupDTO? group;
	int? fixtureSequenceNumber;

  @GameStageConverter()
  GameStage? gameStage;
  
	bool? isUnderway;
	bool? isCompleted;

	MatchDTO();

	factory MatchDTO.fromJson(Map<String, dynamic> json) => _$MatchDTOFromJson(json);

	Map<String, dynamic> toJson() => _$MatchDTOToJson(this);
}