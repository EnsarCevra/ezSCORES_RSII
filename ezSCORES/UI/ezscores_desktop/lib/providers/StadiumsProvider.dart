import 'package:ezscores_desktop/models/stadiums.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';

class StadiumProvider extends BaseProvider<Stadiums>
{
  StadiumProvider(): super("Stadiums");

  @override
  Stadiums fromJson(data) {
    // TODO: implement fromJson
    return Stadiums.fromJson(data);
  }
}