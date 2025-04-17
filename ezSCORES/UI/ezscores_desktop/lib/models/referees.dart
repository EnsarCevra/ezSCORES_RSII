import 'package:json_annotation/json_annotation.dart';

part 'referees.g.dart';

@JsonSerializable()
class Referees {
	int? id;
	String? firstName;
	String? lastName;
	String? picture;

	Referees();

	factory Referees.fromJson(Map<String, dynamic> json) => _$RefereesFromJson(json);

	Map<String, dynamic> toJson() => _$RefereesToJson(this);
}