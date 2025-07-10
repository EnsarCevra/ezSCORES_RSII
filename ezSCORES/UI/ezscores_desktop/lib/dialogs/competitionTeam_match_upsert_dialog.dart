import 'dart:convert';

import 'package:ezscores_desktop/models/DTOs/groupDto.dart';
import 'package:ezscores_desktop/models/DTOs/teamDto.dart';
import 'package:ezscores_desktop/models/competitionsTeams.dart';
import 'package:ezscores_desktop/models/enums/gameStage.dart';
import 'package:ezscores_desktop/models/search_result.dart';
import 'package:ezscores_desktop/providers/CompetitionTeamsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeamSelectionDialog extends StatefulWidget {
  final int competitionId;
  int? competitionTeamId;
  int? oposingCompetitionTeamId;
  GroupDTO? group;
  GameStage gameStage;
  TeamSelectionDialog({super.key, required this.competitionId, required this.gameStage, this.competitionTeamId, this.oposingCompetitionTeamId,this.group});

  @override
  State<TeamSelectionDialog> createState() => _TeamSelectionDialogState();
}

class _TeamSelectionDialogState extends State<TeamSelectionDialog> {
  late CompetitionTeamsProvider competitionTeamsProvider;
  SearchResult<CompetitionsTeams>? competitionsTeamsResult;
  int? selectedCompetitionTeamId;
  @override
  void initState() {
    super.initState();
    competitionTeamsProvider = context.read<CompetitionTeamsProvider>();
    initForm();
  }
  void initForm() async{
    SearchResult<CompetitionsTeams> data;
    if(widget.competitionTeamId != null)
    {
      selectedCompetitionTeamId = widget.competitionTeamId;
    }
    if(widget.gameStage == GameStage.groupPhase && widget.group != null)
    {
      data = await competitionTeamsProvider.get(filter: {"groupId" : widget.group!.id});
    }
    else
    {
      data = await competitionTeamsProvider.get(filter: {"competitionId" : widget.competitionId});
    }
    if(widget.oposingCompetitionTeamId != null)
    {
      data.result = data.result.where((element) => element.id != widget.oposingCompetitionTeamId).toList();
    }
    setState(() {
      competitionsTeamsResult = data;
    });
  }

  void _save() {
    if (selectedCompetitionTeamId != null) {
      if(selectedCompetitionTeamId != widget.competitionTeamId)
      {
        Navigator.pop(context, selectedCompetitionTeamId);
      }
    } else {
      // Optionally show feedback if nothing is selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Molimo odaberite ekipu.")),
      );
    }
  }

  Widget _buildTeamCard(CompetitionsTeams competitionTeam) {
  final isSelected = selectedCompetitionTeamId == competitionTeam.id;
  final hasImage = competitionTeam.team!.picture != null && competitionTeam.team!.picture!.isNotEmpty;
  final imageProvider = hasImage
      ? MemoryImage(base64Decode(competitionTeam.team!.picture!))
      : const AssetImage('assets/images/team_placeholder.png') as ImageProvider;

  return GestureDetector(
    onTap: () {
      setState(() {
        selectedCompetitionTeamId = competitionTeam.id;
      });
    },
    child: Card(
      color: isSelected ? Colors.lightGreen[100] : Colors.white,
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
              backgroundImage: imageProvider,
            ),
            const SizedBox(height: 8),
            Text(
              competitionTeam.team!.name ?? "Nepoznata ekipa",
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ),
  );
}


  @override
Widget build(BuildContext context) {
  return AlertDialog(
    title: const Text("Odaberite ekipu"),
    content: SizedBox(
      width: 900,
      height: 400,
      child: competitionsTeamsResult == null
          ? const Center(child: CircularProgressIndicator())
          : GridView.count(
              crossAxisCount: 6,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: competitionsTeamsResult!.result
                  .map((team) => _buildTeamCard(team))
                  .toList(),
            ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context, null),
        child: const Text("Zatvori"),
      ),
      ElevatedButton(
        onPressed: _save,
        child: const Text("Spremi"),
      ),
    ],
  );
}


}
