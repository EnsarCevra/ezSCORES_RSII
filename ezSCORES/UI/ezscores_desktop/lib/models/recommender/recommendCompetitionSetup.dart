import 'package:ezscores_desktop/models/enums/competitionType.dart';
import 'package:ezscores_desktop/models/enums/competitions_type_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recommendCompetitionSetup.g.dart';

@JsonSerializable(explicitToJson: true)
@CompetitionTypeConverter()
class RecommendedCompetitionSetup {
	CompetitionType? competitionType;
	int? maxTeamCount;
	int? maxPlayersPerTeam;

	RecommendedCompetitionSetup(this.competitionType,this.maxTeamCount,this.maxPlayersPerTeam,);

	factory RecommendedCompetitionSetup.fromJson(Map<String, dynamic> json) => _$RecommendedCompetitionSetupFromJson(json);

	Map<String, dynamic> toJson() => _$RecommendedCompetitionSetupToJson(this);
}
