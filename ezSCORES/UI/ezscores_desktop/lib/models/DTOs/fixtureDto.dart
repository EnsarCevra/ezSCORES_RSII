// -- fixture_dto.dart --
import 'package:ezscores_desktop/models/enums/gameStage.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fixtureDto.g.dart';

@JsonSerializable()
class FixtureDTO {
	int? id;
  GameStage? gameStage;
	int? sequenceNumber;
	bool? isCurrentlyActive;
	bool? isCompleted;

	FixtureDTO(this.id,this.sequenceNumber,this.isCurrentlyActive,this.isCompleted,);

	factory FixtureDTO.fromJson(Map<String, dynamic> json) => _$FixtureDTOFromJson(json);

	Map<String, dynamic> toJson() => _$FixtureDTOToJson(this);
}
