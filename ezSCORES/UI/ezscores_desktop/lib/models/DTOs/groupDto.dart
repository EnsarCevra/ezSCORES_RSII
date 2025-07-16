import 'package:json_annotation/json_annotation.dart';

part 'groupDto.g.dart';

@JsonSerializable(explicitToJson: true)
class GroupDTO {
	int? id;
	String? name;

	GroupDTO({this.id, this.name});

	factory GroupDTO.fromJson(Map<String, dynamic> json) => _$GroupDTOFromJson(json);

	Map<String, dynamic> toJson() => _$GroupDTOToJson(this);
}
