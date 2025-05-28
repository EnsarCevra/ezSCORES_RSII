// -- fixture_dto.dart --
import 'package:ezscores_desktop/models/DTOs/matchDto.dart';
import 'package:ezscores_desktop/models/enums/gameStage.dart';
import 'package:ezscores_desktop/models/enums/game_stage_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fixtureDto.g.dart';

@JsonSerializable()
class FixtureDTO {
	int? id;

  @GameStageConverter()
  GameStage? gameStage;

	int? sequenceNumber;
	bool? isCurrentlyActive;
	bool? isCompleted;
  List<MatchDTO>? matches;

	FixtureDTO(this.id,this.sequenceNumber,this.isCurrentlyActive,this.isCompleted,);

	factory FixtureDTO.fromJson(Map<String, dynamic> json) => _$FixtureDTOFromJson(json);

	Map<String, dynamic> toJson() => _$FixtureDTOToJson(this);
}
