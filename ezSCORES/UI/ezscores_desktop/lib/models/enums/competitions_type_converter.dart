import 'package:ezscores_desktop/models/enums/competitionType.dart';
import 'package:json_annotation/json_annotation.dart';

class CompetitionTypeConverter implements JsonConverter<CompetitionType?, int?> {
  const CompetitionTypeConverter();

  @override
  CompetitionType? fromJson(int? json) {
    if (json == null) return null;
    return CompetitionTypeExtension.fromValue(json);
  }

  @override
  int? toJson(CompetitionType? object) {
    return object?.value;
  }
}
