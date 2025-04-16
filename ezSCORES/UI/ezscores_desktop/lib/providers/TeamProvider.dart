import 'package:ezscores_desktop/models/teams.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';

class TeamProvider extends BaseProvider<Teams>
{
  TeamProvider(): super("Teams");

  @override
  Teams fromJson(data) {
    // TODO: implement fromJson
    return Teams.fromJson(data);
  }
}