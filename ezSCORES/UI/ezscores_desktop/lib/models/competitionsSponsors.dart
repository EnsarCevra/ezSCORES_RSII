import 'package:ezscores_desktop/models/sponsors.dart';
import 'package:json_annotation/json_annotation.dart';

part 'competitionsSponsors.g.dart';

@JsonSerializable()
class CompetitionsSponsors {
	int? id;
	int? competitionId;
	int? sponsorId;
	int? type;
  Sponsors? sponsor;
	CompetitionsSponsors();

	factory CompetitionsSponsors.fromJson(Map<String, dynamic> json) => _$CompetitionsSponsorsFromJson(json);

	Map<String, dynamic> toJson() => _$CompetitionsSponsorsToJson(this);
}
