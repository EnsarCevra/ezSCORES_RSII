import 'package:json_annotation/json_annotation.dart';

part 'sponsors.g.dart';

@JsonSerializable()
class Sponsors {
	int? id;
	String? name;
	String? picture;

	Sponsors();

	factory Sponsors.fromJson(Map<String, dynamic> json) => _$SponsorsFromJson(json);

	Map<String, dynamic> toJson() => _$SponsorsToJson(this);
}