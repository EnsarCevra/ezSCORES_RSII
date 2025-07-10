import 'package:ezscores_desktop/models/competitionsTeamsPlayers.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';

class CompetitionsTeamsPlayersProvider extends BaseProvider<CompetitionsTeamsPlayers>
{
  CompetitionsTeamsPlayersProvider(): super("CompetitionsTeamsPlayers");

  @override
  CompetitionsTeamsPlayers fromJson(data) {
    return CompetitionsTeamsPlayers.fromJson(data);
  }
}