import 'package:ezscores_desktop/models/players.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';

class PlayerProvider extends BaseProvider<Players>
{
  PlayerProvider(): super("Players");

  @override
  Players fromJson(data) {
    // TODO: implement fromJson
    return Players.fromJson(data);
  }
}