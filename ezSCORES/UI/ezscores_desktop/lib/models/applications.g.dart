// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applications.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Applications _$ApplicationsFromJson(Map<String, dynamic> json) => Applications()
  ..id = (json['id'] as num?)?.toInt()
  ..teamId = (json['teamId'] as num?)?.toInt()
  ..competitionId = (json['competitionId'] as num?)?.toInt()
  ..message = json['message'] as String?
  ..isPaId = json['isPaId'] as bool?
  ..paidAmount = (json['paidAmount'] as num?)?.toDouble()
  ..isAccepted = json['isAccepted'] as bool?
  ..team = json['team'] == null
      ? null
      : Teams.fromJson(json['team'] as Map<String, dynamic>);

Map<String, dynamic> _$ApplicationsToJson(Applications instance) =>
    <String, dynamic>{
      'id': instance.id,
      'teamId': instance.teamId,
      'competitionId': instance.competitionId,
      'message': instance.message,
      'isPaId': instance.isPaId,
      'paidAmount': instance.paidAmount,
      'isAccepted': instance.isAccepted,
      'team': instance.team,
    };
