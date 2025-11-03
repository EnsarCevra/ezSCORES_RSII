import 'package:ezscores_desktop/models/cities.dart';
import 'package:ezscores_desktop/models/competitionsReferees.dart';
import 'package:ezscores_desktop/models/competitionsSponsors.dart';
import 'package:ezscores_desktop/models/enums/competitionStatus.dart';
import 'package:ezscores_desktop/models/enums/competitionType.dart';
import 'package:ezscores_desktop/models/enums/competitions_status_converter.dart';
import 'package:ezscores_desktop/models/enums/competitions_type_converter.dart';
import 'package:ezscores_desktop/models/reviews.dart';
import 'package:ezscores_desktop/models/rewards.dart';
import 'package:ezscores_desktop/models/selections.dart';
import 'package:json_annotation/json_annotation.dart';

part 'competitions.g.dart';

@JsonSerializable(explicitToJson: true)
@CompetitionTypeConverter()
@CompetitionStatusConverter()
class Competitions {
	int? id;
	int? userId;
	int? selectionId;
	String? season;
	int? cityId;
	String? name;
	String? description;
	int? maxTeamCount;
	String? picture;
	DateTime? startDate;
	DateTime? applicationEndDate;
	int? fee;
	int? maxPlayersPerTeam;
  CompetitionType? competitionType;
  CompetitionStatus? status;
  Cities? city;
  Selections? selection;
  List<CompetitionsReferees>? competitionsReferees;
  List<CompetitionsSponsors>? competitionsSponsors;
  List<Rewards>? rewards;
  List<Reviews>? reviews;
 
	Competitions({
    this.id,
    this.userId,
    this.selectionId,
    this.season,
    this.cityId,
    this.name,
    this.description,
    this.maxTeamCount,
    this.picture,
    this.startDate,
    this.applicationEndDate,
    this.fee,
    this.maxPlayersPerTeam,
    this.competitionType,
    this.status,
    this.city,
    this.selection,
    this.competitionsReferees,
    this.competitionsSponsors,
    this.rewards,
    this.reviews,
  });

	factory Competitions.fromJson(Map<String, dynamic> json) => _$CompetitionsFromJson(json);

	Map<String, dynamic> toJson() => _$CompetitionsToJson(this);
}