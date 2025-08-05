import 'package:ezscores_mobile/models/goals.dart';
import 'package:ezscores_mobile/providers/base_provider.dart';

class GoalProvider extends BaseProvider<Goals>
{
  GoalProvider(): super("Goals");

  @override
  Goals fromJson(data) {
    return Goals.fromJson(data);
  }
}