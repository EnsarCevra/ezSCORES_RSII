import 'package:ezscores_desktop/models/competitions.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';

class CompetitionProvider extends BaseProvider<Competitions>
{
  CompetitionProvider(): super("Competitions");

  @override
  Competitions fromJson(data) {
    // TODO: implement fromJson
    return Competitions.fromJson(data);
  }
}