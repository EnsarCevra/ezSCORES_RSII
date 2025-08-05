import 'package:json_annotation/json_annotation.dart';

part 'roles.g.dart';

@JsonSerializable()
class Roles {
	int? id;
	String? name;
	String? description;

	Roles({
    this.id,
    this.name,
    this.description,
  });

	factory Roles.fromJson(Map<String, dynamic> json) => _$RolesFromJson(json);

	Map<String, dynamic> toJson() => _$RolesToJson(this);
}
