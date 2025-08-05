import 'package:ezscores_mobile/models/competitionsSponsors.dart';
import 'package:ezscores_mobile/providers/base_provider.dart';

class CompetitionsSponsorsProvider extends BaseProvider<CompetitionsSponsors>
{
  CompetitionsSponsorsProvider(): super("CompetitionsSponsors");

  @override
  CompetitionsSponsors fromJson(data) {
    return CompetitionsSponsors.fromJson(data);
  }
}