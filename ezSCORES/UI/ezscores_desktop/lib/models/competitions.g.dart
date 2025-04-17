// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competitions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Competitions _$CompetitionsFromJson(Map<String, dynamic> json) => Competitions()
  ..id = (json['id'] as num?)?.toInt()
  ..userId = (json['userId'] as num?)?.toInt()
  ..selectionId = (json['selectionId'] as num?)?.toInt()
  ..season = json['season'] as String?
  ..cityId = (json['cityId'] as num?)?.toInt()
  ..name = json['name'] as String?
  ..description = json['description'] as String?
  ..maxTeamCount = (json['maxTeamCount'] as num?)?.toInt()
  ..picture = json['picture'] as String?
  ..startDate = json['startDate'] == null
      ? null
      : DateTime.parse(json['startDate'] as String)
  ..applicationEndDate = json['applicationEndDate'] == null
      ? null
      : DateTime.parse(json['applicationEndDate'] as String)
  ..fee = (json['fee'] as num?)?.toInt()
  ..maxPlayersPerTeam = (json['maxPlayersPerTeam'] as num?)?.toInt()
  ..competitionType =
      $enumDecodeNullable(_$CompetitionTypeEnumMap, json['competitionType'])
  ..competitionStatus =
      $enumDecodeNullable(_$CompetitionStatusEnumMap, json['competitionStatus'])
  ..city = json['city'] == null
      ? null
      : Cities.fromJson(json['city'] as Map<String, dynamic>)
  ..selection = json['selection'] == null
      ? null
      : Selections.fromJson(json['selection'] as Map<String, dynamic>)
  ..competitionsReferees = (json['competitionsReferees'] as List<dynamic>?)
      ?.map((e) => CompetitionsReferees.fromJson(e as Map<String, dynamic>))
      .toList()
  ..competitionsSponsors = (json['competitionsSponsors'] as List<dynamic>?)
      ?.map((e) => CompetitionsSponsors.fromJson(e as Map<String, dynamic>))
      .toList()
  ..rewards = (json['rewards'] as List<dynamic>?)
      ?.map((e) => Rewards.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$CompetitionsToJson(Competitions instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'selectionId': instance.selectionId,
      'season': instance.season,
      'cityId': instance.cityId,
      'name': instance.name,
      'description': instance.description,
      'maxTeamCount': instance.maxTeamCount,
      'picture': instance.picture,
      'startDate': instance.startDate?.toIso8601String(),
      'applicationEndDate': instance.applicationEndDate?.toIso8601String(),
      'fee': instance.fee,
      'maxPlayersPerTeam': instance.maxPlayersPerTeam,
      'competitionType': _$CompetitionTypeEnumMap[instance.competitionType],
      'competitionStatus':
          _$CompetitionStatusEnumMap[instance.competitionStatus],
      'city': instance.city?.toJson(),
      'selection': instance.selection?.toJson(),
      'competitionsReferees':
          instance.competitionsReferees?.map((e) => e.toJson()).toList(),
      'competitionsSponsors':
          instance.competitionsSponsors?.map((e) => e.toJson()).toList(),
      'rewards': instance.rewards?.map((e) => e.toJson()).toList(),
    };

const _$CompetitionTypeEnumMap = {
  CompetitionType.tournamentKnockOutOnly: 'tournamentKnockOutOnly',
  CompetitionType.tournament: 'tournament',
  CompetitionType.league: 'league',
};

const _$CompetitionStatusEnumMap = {
  CompetitionStatus.initial: 'initial',
  CompetitionStatus.preparation: 'preparation',
  CompetitionStatus.applicationsOpen: 'applicationsOpen',
  CompetitionStatus.applicationsClosed: 'applicationsClosed',
  CompetitionStatus.underway: 'underway',
  CompetitionStatus.finished: 'finished',
};
