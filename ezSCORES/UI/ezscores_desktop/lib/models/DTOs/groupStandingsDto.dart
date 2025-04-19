import 'package:ezscores_desktop/models/DTOs/teamStandingsDto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'groupStandingsDto.g.dart';


@JsonSerializable(explicitToJson: true)
class GroupStandingsDTO {
	int? groupId;
	String? groupName;
	List<TeamStandingsDTO>? standings;

	GroupStandingsDTO();

	factory GroupStandingsDTO.fromJson(Map<String, dynamic> json) => _$GroupStandingsDTOFromJson(json);

	Map<String, dynamic> toJson() => _$GroupStandingsDTOToJson(this);
}
