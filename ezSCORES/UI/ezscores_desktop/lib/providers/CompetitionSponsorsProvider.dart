import 'package:ezscores_desktop/models/competitionsSponsors.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';

class CompetitionsSponsorsProvider extends BaseProvider<CompetitionsSponsors>
{
  CompetitionsSponsorsProvider(): super("CompetitionsSponsors");

  @override
  CompetitionsSponsors fromJson(data) {
    return CompetitionsSponsors.fromJson(data);
  }
}