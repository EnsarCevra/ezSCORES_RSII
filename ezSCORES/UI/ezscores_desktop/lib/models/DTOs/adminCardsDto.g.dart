// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adminCardsDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminDashboardCardsDTO _$AdminDashboardCardsDTOFromJson(
        Map<String, dynamic> json) =>
    AdminDashboardCardsDTO(
      (json['competitions'] as num).toInt(),
      (json['teams'] as num).toInt(),
      (json['players'] as num).toInt(),
      CompetitionsByStatusCountDTO.fromJson(
          json['competitionsByStatus'] as Map<String, dynamic>),
      Map<String, int>.from(json['competitionsByMonth'] as Map),
    );

Map<String, dynamic> _$AdminDashboardCardsDTOToJson(
        AdminDashboardCardsDTO instance) =>
    <String, dynamic>{
      'competitions': instance.competitions,
      'teams': instance.teams,
      'players': instance.players,
      'competitionsByStatus': instance.competitionsByStatus,
      'competitionsByMonth': instance.competitionsByMonth,
    };

CompetitionsByStatusCountDTO _$CompetitionsByStatusCountDTOFromJson(
        Map<String, dynamic> json) =>
    CompetitionsByStatusCountDTO(
      (json['preparationCount'] as num).toInt(),
      (json['applicationsOpenedCount'] as num).toInt(),
      (json['applicationsClosedCount'] as num).toInt(),
      (json['underwayCount'] as num).toInt(),
      (json['finishedCount'] as num).toInt(),
    );

Map<String, dynamic> _$CompetitionsByStatusCountDTOToJson(
        CompetitionsByStatusCountDTO instance) =>
    <String, dynamic>{
      'preparationCount': instance.preparationCount,
      'applicationsOpenedCount': instance.applicationsOpenedCount,
      'applicationsClosedCount': instance.applicationsClosedCount,
      'underwayCount': instance.underwayCount,
      'finishedCount': instance.finishedCount,
    };
