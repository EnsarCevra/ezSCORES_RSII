import 'dart:convert';

import 'package:ezscores_desktop/models/DTOs/goalDto.dart';
import 'package:ezscores_desktop/models/competitionsTeamsPlayers.dart';
import 'package:ezscores_desktop/models/search_result.dart';
import 'package:ezscores_desktop/providers/CompetitionTeamPlayerProvider.dart';
import 'package:ezscores_desktop/providers/GoalProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoalUpsertDialog extends StatefulWidget {
  final int matchId;
  final int competitionTeamId;
  final bool isHomeGoal;
  final GoalDTO? goal;
  const GoalUpsertDialog({super.key, this.goal, required this.matchId, required this.competitionTeamId, required this.isHomeGoal});

  @override
  State<GoalUpsertDialog> createState() => _GoalUpsertDialogState();
}

class _GoalUpsertDialogState extends State<GoalUpsertDialog> {
  late GoalProvider goalProvider;
  late CompetitionsTeamsPlayersProvider competitionTeamPlayerProvider;
  SearchResult<CompetitionsTeamsPlayers>? competitionsTeamsPlayersResult;
  int? selectedCompetitionTeamPlayerId;
  int? selectedMinute;
  bool _minuteNotSelectedError = false;

  //get competition team players!

  @override
  void initState() {
    super.initState();
    goalProvider = context.read<GoalProvider>();
    competitionTeamPlayerProvider = context.read<CompetitionsTeamsPlayersProvider>();
    initForm();
  }
  void initForm() async{
    if(widget.goal != null)
    {
      if(widget.goal?.competitionTeamPlayerId != null)
      {
        selectedCompetitionTeamPlayerId = widget.goal!.competitionTeamPlayerId;
      }
      selectedMinute = widget.goal!.scoredAtMinute;
    }
    var data = await competitionTeamPlayerProvider.get(filter: {"competitionTeamId" : widget.competitionTeamId});
    setState(() {
      competitionsTeamsPlayersResult = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.goal == null ? "Novi postignuti pogodak" : "Uredi postignuti pogodak"),
      content: SizedBox(
        width: 600,
        height: 500,
        child: competitionsTeamsPlayersResult == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  // Player cards (80%)
                  Expanded(
                    flex: 4,
                    child: GridView.count(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      children: competitionsTeamsPlayersResult!.result
                          .map((player) => _buildPlayerCard(player))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Minute selection (20%)
                  const SizedBox(height: 10),
                  const Text("Odaberi minutu postignutog pogotka:", style: TextStyle(fontWeight: FontWeight.bold)),

                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(20, (index) => _buildMinuteBox(index + 1)),
                  ),
                  if (_minuteNotSelectedError)
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Molimo odaberite minutu postignutog pogotka.",
                        style: TextStyle(color: Colors.red, fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Odustani"),
        ),
        ElevatedButton(
          onPressed: _saveGoal,
          child: const Text("Spremi"),
        ),
      ],
    );
  }

  Future<void> _saveGoal() async {
    if(selectedMinute == null)
    {
      setState(() {
        _minuteNotSelectedError = true;
      });
      return;
    }

    setState(() {
      _minuteNotSelectedError = false;
    });
    var request = {
      "competitionTeamPlayerId" : selectedCompetitionTeamPlayerId,
      "scoredAtMinute" : selectedMinute,
      "isHomeGoal" : widget.isHomeGoal
    };
      try {
        if (widget.goal == null) {
          request['matchId'] = widget.matchId;
          await goalProvider.insert(request);
        } else {
          await goalProvider.update(widget.goal!.id!, request);
        }
        Navigator.pop(context, true);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Greška"),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              )
            ],
          ),
        );
      }
  }
Widget _buildPlayerCard(CompetitionsTeamsPlayers player) {
  final isSelected = selectedCompetitionTeamPlayerId == player.id;

  return GestureDetector(
    onTap: () {
      setState(() {
        selectedCompetitionTeamPlayerId = player.id;
      });
    },
    child: SizedBox(
      height: 140,
      width: 120,
      child: Card(
        color: isSelected ? Colors.lightGreen[300] : Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isSelected ? Colors.green : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                backgroundImage: player.player?.picture != null
                    ? MemoryImage(base64Decode(player.player!.picture!))
                    : null,
                child: player.player?.picture == null
                    ? const Icon(Icons.account_circle, size: 50)
                    : null,
              ),
              const SizedBox(height: 8),
              Text(
                "${player.player?.firstName ?? 'Nepoznat'} ${player.player?.lastName ?? 'Igrač'}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


Widget _buildMinuteBox(int minute) {
  final isSelected = selectedMinute == minute;
  return GestureDetector(
    onTap: () {
      setState(() {
        selectedMinute = minute;
      });
    },
    child: Container(
      width: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? Colors.lightBlueAccent : Colors.grey.shade200,
        border: Border.all(color: isSelected ? Colors.blue : Colors.grey),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '$minute',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    ),
  );
}

}
