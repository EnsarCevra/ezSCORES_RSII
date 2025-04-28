import 'package:json_annotation/json_annotation.dart';
part 'selections.g.dart';
@JsonSerializable()
class Selections{
  int? id;
  String? name;
  int? ageMax;

  Selections({this.id, this.name, this.ageMax});
   factory Selections.fromJson(Map<String, dynamic> json) => _$SelectionsFromJson(json);
  Map<String, dynamic> toJson() => _$SelectionsToJson(this);
}