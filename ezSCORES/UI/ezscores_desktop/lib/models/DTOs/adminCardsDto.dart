import 'package:json_annotation/json_annotation.dart';

part 'adminCardsDto.g.dart';

@JsonSerializable()
class AdminDashboardCardsDTO {
	int competitions;
	int teams;
	int players;
  double? totalFeeAmount;
  CompetitionsByStatusCountDTO competitionsByStatus;
  Map<String, int> competitionsByMonth;

	AdminDashboardCardsDTO(this.competitions,this.teams,this.players, this.competitionsByStatus, this.competitionsByMonth);

	factory AdminDashboardCardsDTO.fromJson(Map<String, dynamic> json) => _$AdminDashboardCardsDTOFromJson(json);

	Map<String, dynamic> toJson() => _$AdminDashboardCardsDTOToJson(this);
}
@JsonSerializable()
class CompetitionsByStatusCountDTO {
	int preparationCount;
	int applicationsOpenedCount;
	int applicationsClosedCount;
	int underwayCount;
	int finishedCount;

	CompetitionsByStatusCountDTO(this.preparationCount,this.applicationsOpenedCount,this.applicationsClosedCount,this.underwayCount,this.finishedCount,);

	factory CompetitionsByStatusCountDTO.fromJson(Map<String, dynamic> json) => _$CompetitionsByStatusCountDTOFromJson(json);

	Map<String, dynamic> toJson() => _$CompetitionsByStatusCountDTOToJson(this);
}