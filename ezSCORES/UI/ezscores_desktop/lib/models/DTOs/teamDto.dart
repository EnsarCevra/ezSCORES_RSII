import 'package:ezscores_desktop/models/DTOs/playerDto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'teamDto.g.dart';

@JsonSerializable(explicitToJson: true)
class TeamDTO {
	int? id;
	String? name;
  List<PlayerDTO>? players;

	TeamDTO({this.id, this.name});

	factory TeamDTO.fromJson(Map<String, dynamic> json) => _$TeamDTOFromJson(json);

	Map<String, dynamic> toJson() => _$TeamDTOToJson(this);
}
