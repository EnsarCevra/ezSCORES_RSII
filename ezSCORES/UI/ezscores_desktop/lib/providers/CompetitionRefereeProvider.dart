import 'package:ezscores_desktop/models/competitionsReferees.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';

class CompetitionsRefereesProvider extends BaseProvider<CompetitionsReferees>
{
  CompetitionsRefereesProvider(): super("CompetitionsReferees");

  @override
  CompetitionsReferees fromJson(data) {
    return CompetitionsReferees.fromJson(data);
  }
}