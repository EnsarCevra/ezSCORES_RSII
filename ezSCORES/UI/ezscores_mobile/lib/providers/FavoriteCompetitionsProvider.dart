import 'package:ezscores_mobile/models/favoriteCompetitions.dart';
import 'package:ezscores_mobile/providers/base_provider.dart';

class FavoriteCompetitionsProvider extends BaseProvider<FavoriteCompetitions>
{
  FavoriteCompetitionsProvider(): super("favoriteCompetitions");

  @override
  FavoriteCompetitions fromJson(data) {
    return FavoriteCompetitions.fromJson(data);
  }
}