import 'package:ezscores_mobile/models/sponsors.dart';
import 'package:ezscores_mobile/providers/base_provider.dart';

class SponsorProvider extends BaseProvider<Sponsors>
{
  SponsorProvider(): super("Sponsors");

  @override
  Sponsors fromJson(data) {
    // TODO: implement fromJson
    return Sponsors.fromJson(data);
  }
}