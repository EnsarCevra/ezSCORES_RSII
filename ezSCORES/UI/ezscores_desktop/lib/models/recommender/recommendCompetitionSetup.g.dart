// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendCompetitionSetup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendedCompetitionSetup _$RecommendedCompetitionSetupFromJson(
        Map<String, dynamic> json) =>
    RecommendedCompetitionSetup(
      const CompetitionTypeConverter()
          .fromJson((json['competitionType'] as num?)?.toInt()),
      (json['maxTeamCount'] as num?)?.toInt(),
      (json['maxPlayersPerTeam'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RecommendedCompetitionSetupToJson(
        RecommendedCompetitionSetup instance) =>
    <String, dynamic>{
      'competitionType':
          const CompetitionTypeConverter().toJson(instance.competitionType),
      'maxTeamCount': instance.maxTeamCount,
      'maxPlayersPerTeam': instance.maxPlayersPerTeam,
    };
