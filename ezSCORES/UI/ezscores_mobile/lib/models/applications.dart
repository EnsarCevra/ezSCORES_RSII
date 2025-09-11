import 'package:json_annotation/json_annotation.dart';
import 'package:ezscores_mobile/models/teams.dart';
import 'package:ezscores_mobile/models/competitions.dart';
part 'applications.g.dart';

@JsonSerializable()
class Applications {
	int? id;
	int? teamId;
	int? competitionId;
	String? message;
	bool? isPaId;
  double? paidAmount;
	bool? isAccepted;
  Teams? team;
  Competitions? competition;

	Applications();

	factory Applications.fromJson(Map<String, dynamic> json) => _$ApplicationsFromJson(json);

	Map<String, dynamic> toJson() => _$ApplicationsToJson(this);
}
