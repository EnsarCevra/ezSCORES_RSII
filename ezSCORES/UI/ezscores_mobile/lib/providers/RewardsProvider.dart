import 'package:ezscores_mobile/models/rewards.dart';
import 'package:ezscores_mobile/providers/base_provider.dart';

class RewardProvider extends BaseProvider<Rewards>
{
  RewardProvider(): super("Rewards");

  @override
  Rewards fromJson(data) {
    return Rewards.fromJson(data);
  }
}