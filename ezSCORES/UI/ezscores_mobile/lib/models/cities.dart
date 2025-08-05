import 'package:json_annotation/json_annotation.dart';

part 'cities.g.dart';

@JsonSerializable()
class Cities {
	int? id;
	String? name;

	Cities();

	factory Cities.fromJson(Map<String, dynamic> json) => _$CitiesFromJson(json);

	Map<String, dynamic> toJson() => _$CitiesToJson(this);
}