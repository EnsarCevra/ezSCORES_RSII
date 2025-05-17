import 'package:ezscores_desktop/models/cities.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';

class CityProvider extends BaseProvider<Cities>
{
  CityProvider(): super("Cities");

  @override
  Cities fromJson(data) {
    // TODO: implement fromJson
    return Cities.fromJson(data);
  }
}