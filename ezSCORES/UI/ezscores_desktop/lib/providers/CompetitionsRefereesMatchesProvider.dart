import 'package:ezscores_desktop/models/competitionsRefereesMatches.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';

class CompeititionRefereeMatchProvider extends BaseProvider<CompetitionsRefereesMatches>
{
  CompeititionRefereeMatchProvider(): super("CompetitionsRefereesMatches");

  @override
  CompetitionsRefereesMatches fromJson(data) {
    return CompetitionsRefereesMatches.fromJson(data);
  }
}