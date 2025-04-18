import 'package:json_annotation/json_annotation.dart';

part 'favoriteCompetitions.g.dart';

@JsonSerializable()
class FavoriteCompetitions {
	int? id;
	int? userId;
	int? competitionId;

	FavoriteCompetitions();

	factory FavoriteCompetitions.fromJson(Map<String, dynamic> json) => _$FavoriteCompetitionsFromJson(json);

	Map<String, dynamic> toJson() => _$FavoriteCompetitionsToJson(this);
}
