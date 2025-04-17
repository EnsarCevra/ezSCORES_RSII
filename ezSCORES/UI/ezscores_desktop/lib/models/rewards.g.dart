// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rewards.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rewards _$RewardsFromJson(Map<String, dynamic> json) => Rewards()
  ..id = (json['id'] as num?)?.toInt()
  ..competitionId = (json['competitionId'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..rankingPosition = (json['rankingPosition'] as num?)?.toInt()
  ..amount = (json['amount'] as num?)?.toInt()
  ..description = json['description'] as String?;

Map<String, dynamic> _$RewardsToJson(Rewards instance) => <String, dynamic>{
      'id': instance.id,
      'competitionId': instance.competitionId,
      'name': instance.name,
      'rankingPosition': instance.rankingPosition,
      'amount': instance.amount,
      'description': instance.description,
    };
