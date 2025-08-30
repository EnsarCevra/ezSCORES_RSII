import 'package:ezscores_mobile/models/DTOs/matchDto.dart';
import 'package:ezscores_mobile/models/competitions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'matchesByDateDto.g.dart';

@JsonSerializable()
class MatchesByDateDTO {
	Competitions? competition;
	List<MatchDTO>? matches;

	MatchesByDateDTO(this.competition,this.matches,);

	factory MatchesByDateDTO.fromJson(Map<String, dynamic> json) => _$MatchesByDateDTOFromJson(json);

	Map<String, dynamic> toJson() => _$MatchesByDateDTOToJson(this);
}