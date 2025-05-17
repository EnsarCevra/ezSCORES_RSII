import 'package:ezscores_desktop/models/competitionsTeams.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';

class CompetitionTeamsProvider extends BaseProvider<CompetitionsTeams>
{
  CompetitionTeamsProvider(): super("CompetitionTeams");

  @override
  CompetitionsTeams fromJson(data) {
    // TODO: implement fromJson
    return CompetitionsTeams.fromJson(data);
  }
}