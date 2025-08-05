import 'package:ezscores_mobile/models/enums/gameStage.dart';
import 'package:ezscores_mobile/models/enums/game_stage_converter.dart';
import 'package:ezscores_mobile/models/matches.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fixtures.g.dart';

@GameStageConverter()
@JsonSerializable()
class Fixtures {
	int? id;
	int? competitionId;
	int? sequenceNumber;
	int? matchLength;
	bool? isCurrentlyActive;
	bool? isCompleted;
  GameStage? gameStage;
  List<Matches>? matches;

	Fixtures();

	factory Fixtures.fromJson(Map<String, dynamic> json) => _$FixturesFromJson(json);

	Map<String, dynamic> toJson() => _$FixturesToJson(this);
}
