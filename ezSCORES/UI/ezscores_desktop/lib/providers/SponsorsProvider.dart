import 'package:ezscores_desktop/models/sponsors.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';

class SponsorProvider extends BaseProvider<Sponsors>
{
  SponsorProvider(): super("Sponsors");

  @override
  Sponsors fromJson(data) {
    // TODO: implement fromJson
    return Sponsors.fromJson(data);
  }
}