import 'package:ezscores_mobile/models/teams.dart';
import 'package:ezscores_mobile/providers/base_provider.dart';

class TeamProvider extends BaseProvider<Teams>
{
  TeamProvider(): super("Teams");

  @override
  Teams fromJson(data) {
    // TODO: implement fromJson
    return Teams.fromJson(data);
  }
}