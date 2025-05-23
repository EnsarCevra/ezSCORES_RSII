import 'package:ezscores_desktop/dialogs/rewards_upsert_dialog.dart';
import 'package:ezscores_desktop/models/rewards.dart';
import 'package:ezscores_desktop/models/search_result.dart';
import 'package:ezscores_desktop/providers/RewardsProvider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RewardsTab extends StatefulWidget {
  final int competitionId;
  const RewardsTab({
    super.key,
    required this.competitionId,
  });

  @override
  State<RewardsTab> createState() => _RewardsTabState();
}

class _RewardsTabState extends State<RewardsTab> {
  late RewardProvider rewardProvider;
  SearchResult<Rewards>? rewardsResult;

  @override
  void initState() {
    rewardProvider = context.read<RewardProvider>();
    super.initState();
    initForm();
  } 

  Future initForm() async{
    var filter = {
      "competitionId" : widget.competitionId
    };
    var rewardsData = await rewardProvider.get(filter: filter);
    setState(() {
      rewardsResult = rewardsData;
    });
   }

@override
Widget build(BuildContext context) {
  if (rewardsResult == null) {
    return const Center(child: CircularProgressIndicator());
  }

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton.icon(
              onPressed: () async {
                final actionResult = await showDialog<bool>(
                context: context,
                builder: (context) => RewardsDialog(competitionId: widget.competitionId,));
                if (actionResult == true) {
                  initForm();
                }
              },
              icon: const Icon(Icons.add),
              label: const Text("Dodaj nagradu"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        rewardsResult!.result.isEmpty
            ? const Expanded(
                child: Center(
                  child: Text("Nema dostupnih nagrada"),
                ),
              )
            : Expanded(
                child: GridView.builder(
                  itemCount: rewardsResult!.result.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 4 / 3,
                  ),
                  itemBuilder: (context, index) {
                    final reward = rewardsResult!.result[index];

                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 4,
                            right: 4,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  tooltip: "Uredi",
                                  onPressed: () async {
                                    final actionResult = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => RewardsDialog(
                                        competitionId: widget.competitionId,
                                        reward: reward,
                                      ),
                                    );
                                    if (actionResult == true) {
                                      initForm();
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  tooltip: "Obriši",
                                  onPressed: () {
                                    _deleteReward(reward.id);
                                  },
                                ),
                              ],
                            ),
                          ),
                          // Center content
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.emoji_events,
                                size: reward.rankingPosition == 1 ? 100 : (reward.rankingPosition == 2 ? 60 : 48), color: Colors.orange),
                                const SizedBox(height: 12),
                                Text(
                                  reward.name ?? "-",
                                  style: Theme.of(context).textTheme.titleMedium,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "${reward.amount?.toStringAsFixed(2) ?? '-'} KM",
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey[700]),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ],
    ),
  );
}

  void _deleteReward(int? rewardId) async{
    try {
      await rewardProvider.delete(rewardId!);
      if(context.mounted)
      {
        showBottomRightNotification(context, 'Nagrada uspješno uklonjena!');
        initForm(); 
      }
    } catch (e) {
        showDialog(
          context: context, 
          builder: (context) => AlertDialog(
          title: const Text("Error"), 
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("Ok"))], 
          content: Text(e.toString()),));
      }
  }

}