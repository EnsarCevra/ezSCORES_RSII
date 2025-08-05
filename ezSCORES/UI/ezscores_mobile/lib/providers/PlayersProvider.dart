import 'package:ezscores_mobile/models/players.dart';
import 'package:ezscores_mobile/providers/base_provider.dart';

class PlayerProvider extends BaseProvider<Players>
{
  PlayerProvider(): super("Players");

  @override
  Players fromJson(data) {
    // TODO: implement fromJson
    return Players.fromJson(data);
  }
}