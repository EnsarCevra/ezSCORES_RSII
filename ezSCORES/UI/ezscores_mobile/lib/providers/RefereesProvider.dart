import 'package:ezscores_mobile/models/referees.dart';
import 'package:ezscores_mobile/providers/base_provider.dart';

class RefereeProvider extends BaseProvider<Referees>
{
  RefereeProvider(): super("Referees");

  @override
  Referees fromJson(data) {
    // TODO: implement fromJson
    return Referees.fromJson(data);
  }
}