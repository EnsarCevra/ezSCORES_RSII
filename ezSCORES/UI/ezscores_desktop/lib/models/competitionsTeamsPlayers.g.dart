// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competitionsTeamsPlayers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompetitionsTeamsPlayers _$CompetitionsTeamsPlayersFromJson(
        Map<String, dynamic> json) =>
    CompetitionsTeamsPlayers()
      ..id = (json['id'] as num?)?.toInt()
      ..competitionsTeamsId = (json['competitionsTeamsId'] as num?)?.toInt()
      ..playerId = (json['playerId'] as num?)?.toInt()
      ..goalsTotal = (json['goalsTotal'] as num?)?.toInt()
      ..isVerified = json['isVerified'] as bool?
      ..player = json['player'] == null
          ? null
          : Players.fromJson(json['player'] as Map<String, dynamic>);

Map<String, dynamic> _$CompetitionsTeamsPlayersToJson(
        CompetitionsTeamsPlayers instance) =>
    <String, dynamic>{
      'id': instance.id,
      'competitionsTeamsId': instance.competitionsTeamsId,
      'playerId': instance.playerId,
      'goalsTotal': instance.goalsTotal,
      'isVerified': instance.isVerified,
      'player': instance.player,
    };
