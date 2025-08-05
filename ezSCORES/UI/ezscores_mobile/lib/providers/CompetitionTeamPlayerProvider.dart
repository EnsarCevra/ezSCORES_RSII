import 'package:ezscores_mobile/models/competitionsTeamsPlayers.dart';
import 'package:ezscores_mobile/providers/base_provider.dart';

class CompetitionsTeamsPlayersProvider extends BaseProvider<CompetitionsTeamsPlayers>
{
  CompetitionsTeamsPlayersProvider(): super("CompetitionsTeamsPlayers");

  @override
  CompetitionsTeamsPlayers fromJson(data) {
    return CompetitionsTeamsPlayers.fromJson(data);
  }
}