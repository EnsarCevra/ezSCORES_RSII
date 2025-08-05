import 'package:ezscores_mobile/models/competitionsRefereesMatches.dart';
import 'package:ezscores_mobile/providers/base_provider.dart';

class CompeititionRefereeMatchProvider extends BaseProvider<CompetitionsRefereesMatches>
{
  CompeititionRefereeMatchProvider(): super("CompetitionsRefereesMatches");

  @override
  CompetitionsRefereesMatches fromJson(data) {
    return CompetitionsRefereesMatches.fromJson(data);
  }
}