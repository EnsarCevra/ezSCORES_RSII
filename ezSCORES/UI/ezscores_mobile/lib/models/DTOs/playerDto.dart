import 'package:json_annotation/json_annotation.dart';

part 'playerDto.g.dart';

@JsonSerializable()
class PlayerDTO {
  int? id;
  String? name;

  PlayerDTO(); // No positional constructor

  factory PlayerDTO.fromJson(Map<String, dynamic> json) =>  _$PlayerDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerDTOToJson(this);
}
