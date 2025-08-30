import 'package:ezscores_mobile/models/cities.dart';
import 'package:ezscores_mobile/models/competitionsReferees.dart';
import 'package:ezscores_mobile/models/competitionsSponsors.dart';
import 'package:ezscores_mobile/models/enums/competitionStatus.dart';
import 'package:ezscores_mobile/models/enums/competitionType.dart';
import 'package:ezscores_mobile/models/enums/competitions_status_converter.dart';
import 'package:ezscores_mobile/models/enums/competitions_type_converter.dart';
import 'package:ezscores_mobile/models/reviews.dart';
import 'package:ezscores_mobile/models/rewards.dart';
import 'package:ezscores_mobile/models/selections.dart';
import 'package:ezscores_mobile/models/users.dart';
import 'package:json_annotation/json_annotation.dart';

part 'competitions.g.dart';

@JsonSerializable(explicitToJson: true)
@CompetitionTypeConverter()
@CompetitionStatusConverter()
class Competitions {
	int? id;
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
  Users? user;
  CompetitionType? competitionType;
  CompetitionStatus? status;
  Cities? city;
  Selections? selection;
  List<CompetitionsReferees>? competitionsReferees;
  List<CompetitionsSponsors>? competitionsSponsors;
  List<Rewards>? rewards;
  List<Reviews>? reviews;
 
	Competitions();

	factory Competitions.fromJson(Map<String, dynamic> json) => _$CompetitionsFromJson(json);

	Map<String, dynamic> toJson() => _$CompetitionsToJson(this);
}