import 'package:ezscores_mobile/models/enums/competitionStatus.dart';
import 'package:json_annotation/json_annotation.dart';

class CompetitionStatusConverter implements JsonConverter<CompetitionStatus?, int?> {
  const CompetitionStatusConverter();

  @override
  CompetitionStatus? fromJson(int? json) {
    if (json == null) return null;
    return CompetitionStatusExtension.fromValue(json);
  }

  @override
  int? toJson(CompetitionStatus? object) {
    return object?.value;
  }
}
