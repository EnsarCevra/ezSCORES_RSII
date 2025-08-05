// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reviews _$ReviewsFromJson(Map<String, dynamic> json) => Reviews()
  ..id = (json['id'] as num?)?.toInt()
  ..userId = (json['userId'] as num?)?.toInt()
  ..competitionId = (json['competitionId'] as num?)?.toInt()
  ..rating = (json['rating'] as num?)?.toDouble();

Map<String, dynamic> _$ReviewsToJson(Reviews instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'competitionId': instance.competitionId,
      'rating': instance.rating,
    };
