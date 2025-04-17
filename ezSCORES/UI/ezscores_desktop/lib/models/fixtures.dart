import 'package:ezscores_desktop/models/enums/gameStage.dart';
import 'package:ezscores_desktop/models/matches.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fixtures.g.dart';

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
