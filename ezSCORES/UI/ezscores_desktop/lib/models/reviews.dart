import 'package:json_annotation/json_annotation.dart';

part 'reviews.g.dart';

@JsonSerializable()
class Reviews {
	int? id;
	int? userId;
	int? competitionId;
	double? rating;

	Reviews();

	factory Reviews.fromJson(Map<String, dynamic> json) => _$ReviewsFromJson(json);

	Map<String, dynamic> toJson() => _$ReviewsToJson(this);
}
