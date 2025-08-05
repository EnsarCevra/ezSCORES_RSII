import 'package:ezscores_mobile/models/players.dart';
import 'package:ezscores_mobile/models/roles.dart';
import 'package:ezscores_mobile/providers/base_provider.dart';

class RolesProvider extends BaseProvider<Roles>
{
  RolesProvider(): super("Roles");

  @override
  Roles fromJson(data) {
    // TODO: implement fromJson
    return Roles.fromJson(data);
  }
}