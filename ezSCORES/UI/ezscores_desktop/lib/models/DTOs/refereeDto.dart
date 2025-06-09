import 'package:json_annotation/json_annotation.dart';

part 'refereeDto.g.dart';

@JsonSerializable(explicitToJson: true)
class RefereeDTO {
	int? id;
  int? competitionRefereeId;
	String? name;

	RefereeDTO();

	factory RefereeDTO.fromJson(Map<String, dynamic> json) => _$RefereeDTOFromJson(json);

	Map<String, dynamic> toJson() => _$RefereeDTOToJson(this);
}
