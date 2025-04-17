import 'package:json_annotation/json_annotation.dart';

part 'stadiums.g.dart';

@JsonSerializable()
class Stadiums {
	int? id;
	String? name;
	String? picture;

	Stadiums();

	factory Stadiums.fromJson(Map<String, dynamic> json) => _$StadiumsFromJson(json);

	Map<String, dynamic> toJson() => _$StadiumsToJson(this);
}