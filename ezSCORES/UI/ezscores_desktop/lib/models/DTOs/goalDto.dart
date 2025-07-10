import 'package:json_annotation/json_annotation.dart';

part 'goalDto.g.dart';

@JsonSerializable()
class GoalDTO {
	int? id;
  int? competitionTeamPlayerId;
	String? scorer;
	int? scoredAtMinute;
	bool? isHomeGoal;
	int? sequenceNumber;

	GoalDTO(this.id,this.scorer,this.scoredAtMinute,this.isHomeGoal,this.sequenceNumber,);

	factory GoalDTO.fromJson(Map<String, dynamic> json) => _$GoalDTOFromJson(json);

	Map<String, dynamic> toJson() => _$GoalDTOToJson(this);
}
