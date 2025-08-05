import 'package:ezscores_mobile/models/cities.dart';
import 'package:ezscores_mobile/providers/base_provider.dart';

class CityProvider extends BaseProvider<Cities>
{
  CityProvider(): super("Cities");

  @override
  Cities fromJson(data) {
    // TODO: implement fromJson
    return Cities.fromJson(data);
  }
}