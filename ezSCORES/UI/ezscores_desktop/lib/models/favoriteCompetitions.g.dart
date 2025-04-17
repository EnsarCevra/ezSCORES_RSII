// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favoriteCompetitions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteCompetitions _$FavoriteCompetitionsFromJson(
        Map<String, dynamic> json) =>
    FavoriteCompetitions()
      ..id = (json['id'] as num?)?.toInt()
      ..userId = (json['userId'] as num?)?.toInt()
      ..competitionId = (json['competitionId'] as num?)?.toInt();

Map<String, dynamic> _$FavoriteCompetitionsToJson(
        FavoriteCompetitions instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'competitionId': instance.competitionId,
    };
