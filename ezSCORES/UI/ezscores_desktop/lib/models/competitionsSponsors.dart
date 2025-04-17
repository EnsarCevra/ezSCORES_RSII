// -- competitions_sponsors.dart --
import 'package:json_annotation/json_annotation.dart';

part 'competitionsSponsors.g.dart';

@JsonSerializable()
class CompetitionsSponsors {
	int? id;
	int? competitionId;
	int? sponsorId;
	int? type;

	CompetitionsSponsors();

	factory CompetitionsSponsors.fromJson(Map<String, dynamic> json) => _$CompetitionsSponsorsFromJson(json);

	Map<String, dynamic> toJson() => _$CompetitionsSponsorsToJson(this);
}
