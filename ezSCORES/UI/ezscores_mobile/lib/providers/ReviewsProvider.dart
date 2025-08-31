import 'package:ezscores_mobile/models/reviews.dart';
import 'package:ezscores_mobile/providers/base_provider.dart';

class ReviewsProvider extends BaseProvider<Reviews>
{
  ReviewsProvider(): super("Reviews");

  @override
  Reviews fromJson(data) {
    // TODO: implement fromJson
    return Reviews.fromJson(data);
  }
}