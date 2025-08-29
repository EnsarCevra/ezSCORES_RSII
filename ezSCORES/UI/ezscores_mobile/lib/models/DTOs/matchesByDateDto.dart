import 'package:ezscores_mobile/models/DTOs/matchDto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'matchesByDateDto.g.dart';

@JsonSerializable()
class MatchesByDateDTO {
	int? competitionId;
	String? competitionName;
	List<MatchDTO>? matches;

	MatchesByDateDTO(this.competitionId,this.competitionName,this.matches,);

	factory MatchesByDateDTO.fromJson(Map<String, dynamic> json) => _$MatchesByDateDTOFromJson(json);

	Map<String, dynamic> toJson() => _$MatchesByDateDTOToJson(this);
}