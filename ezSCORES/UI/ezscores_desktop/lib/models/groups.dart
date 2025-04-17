import 'package:ezscores_desktop/models/competitionsTeams.dart';
import 'package:json_annotation/json_annotation.dart';

part 'groups.g.dart';

@JsonSerializable()
class Groups {
	int? id;
	int? competitionId;
	String? name;
	List<CompetitionsTeams>? competitionsTeams;

	Groups();

	factory Groups.fromJson(Map<String, dynamic> json) => _$GroupsFromJson(json);

	Map<String, dynamic> toJson() => _$GroupsToJson(this);
}
