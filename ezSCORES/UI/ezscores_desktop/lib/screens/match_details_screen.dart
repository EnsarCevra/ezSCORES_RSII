import 'dart:convert';
import 'package:ezscores_desktop/dialogs/assign_match_referees_dialog.dart';
import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/models/DTOs/fixtureDto.dart';
import 'package:ezscores_desktop/models/DTOs/goalDto.dart';
import 'package:ezscores_desktop/models/DTOs/matchDto.dart';
import 'package:ezscores_desktop/models/DTOs/playerDto.dart';
import 'package:ezscores_desktop/models/enums/gameStage.dart';
import 'package:ezscores_desktop/providers/CompetitionRefereeProvider.dart';
import 'package:ezscores_desktop/providers/CompetitionsRefereesMatchesProvider.dart';
import 'package:ezscores_desktop/providers/MatchesProvider.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MatchDetailsScreen extends StatefulWidget {
  int competitionId;
  int? matchID;
  FixtureDTO fixture;
  MatchDetailsScreen({super.key, this.matchID, required this.fixture, required this.competitionId});

  @override
  State<MatchDetailsScreen> createState() => _MatchDetailsScreenState();
}

class _MatchDetailsScreenState extends State<MatchDetailsScreen> {
  late MatchesProvider matchesProvider;
  late CompetitionsRefereesProvider competitionsRefereesProvider;
  late CompeititionRefereeMatchProvider compeititionRefereeMatchProvider;
  MatchDTO? match;

  @override
  void initState() {
    matchesProvider = context.read<MatchesProvider>();
    competitionsRefereesProvider = context.read<CompetitionsRefereesProvider>();
    compeititionRefereeMatchProvider = context.read<CompeititionRefereeMatchProvider>();
    super.initState();
    initForm();
  }

  Future initForm() async {
    if (widget.matchID != null) {
      match = await matchesProvider.getMatchDetails(widget.matchID!);
      if (match!.goals != null) {
        match!.homeTeamScore = match!.goals!.where((e) => e.isHomeGoal == true).length;
        match!.awayTeamScore = match!.goals!.where((e) => e.isHomeGoal == false).length;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (match == null) {
      return MasterScreen(
        "Detalji utakmice",
        selectedIndex: 1,
        const Center(child: CircularProgressIndicator()),
      );
    }

    return MasterScreen(
      "Detalji utakmice",
      selectedIndex: 1,
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildMainInfo(),
              const SizedBox(height: 16),
              _buildPlayerData(),
              const SizedBox(height: 16),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainInfo() {
    final bool isFinished = match?.isCompleted ?? false;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/match_bg_3.jpeg'),
          fit: BoxFit.cover,
          opacity: 0.9,
        ),
        border: Border.all(color: Colors.grey.shade400, width: 1.5),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(match?.homeTeam?.name ?? "", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(width: 16),
              Text(
                isFinished || match!.isUnderway == true ? "${match?.homeTeamScore} : ${match?.awayTeamScore}" : "- : -",
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Text(match?.awayTeam?.name ?? "", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.calendar_today, size: 20, color: Colors.white),
              const SizedBox(width: 4),
              Text("${formatDateTime(match!.dateAndTime)} • ", style: const TextStyle(color: Colors.white, fontSize: 20)),
              const Icon(Icons.stadium, size: 20, color: Colors.white),
              const SizedBox(width: 4),
              Text(match?.stadium ?? "Nepoznat stadion", style: const TextStyle(color: Colors.white, fontSize: 20)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${widget.fixture.gameStage!.displayName}"
                "${(widget.fixture.gameStage == GameStage.league || widget.fixture.gameStage == GameStage.groupPhase) ? " • ${widget.fixture.sequenceNumber! + 1}. kolo" : ""}"
                " • ${match!.group}",
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
          if (isFinished && match?.goals != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _strikersList(match!.goals!),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }

  Widget _buildPlayerData() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: _playersList("Igrači domaćina", match?.homeTeam?.players, true),
        ),
        Flexible(
          flex: 1,
          child: _referees(),
        ),
        Flexible(
          flex: 1,
          child: _playersList("Igrači gosta", match?.awayTeam?.players, false),
        ),
      ],
    );
  }

  Widget _playersList(String title, List<PlayerDTO>? players, bool isHomeList) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: isHomeList ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: players?.length ?? 0,
              itemBuilder: (context, index) {
                final player = players![index];
                return Container(
                  alignment: isHomeList ? Alignment.centerLeft : Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(player.name!, style: const TextStyle(fontSize: 16)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
        onPressed: _save,
        child: const Text("Spremi"),
      ),
    );
  }

  Widget _referees() {
    final referees = match?.referees ?? [];

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Sudski arbitar",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (referees.isNotEmpty)
            ...referees.map(
              (ref) => Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(ref.name!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                      tooltip: "Ukloni sudiju",
                      onPressed: () => _unassignReferee(ref.id!),
                    ),
                  ],
                ),
              ),
            )
          else
            const Text("Nema dodijeljenih sudija."),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AssignRefereesDialog(
                  competitionId: widget.competitionId,
                  matchId: widget.matchID!,
                  initiallyAssignedReferees: match!.referees!,
                  onClose: () {
                    setState(() {
                      initForm();
                    });
                  },
                ),
              );
            },
            child: const Text("Dodijeli"),
          ),
        ],
      ),
    );
  }

  Widget _strikersList(List<GoalDTO> goals) {
    return Column(
      children: goals.map((goal) {
        final minute = goal.scoredAtMinute != null ? "${goal.scoredAtMinute}'" : "";
        final strikerText = goal.scorer != null ? "⚽$minute ${goal.scorer}" : "⚽$minute Nepoznat strijelac";
        final isLeft = goal.isHomeGoal!;
        return Row(
          mainAxisAlignment: isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade600,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(strikerText, style: const TextStyle(color: Colors.white)),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _teamLogo(String? base64Image) {
    if (base64Image == null || base64Image.isEmpty) {
      return const SizedBox(width: 40, height: 40);
    }

    return Image.memory(
      base64Decode(base64Image),
      width: 40,
      height: 40,
      fit: BoxFit.cover,
    );
  }

  void _save() {}

  Future<void> _unassignReferee(int competitionRefereeMatchId) async {
    try {
      await compeititionRefereeMatchProvider.delete(competitionRefereeMatchId);
      if (!mounted) return;
      setState(() {
        initForm();
      });
      showBottomRightNotification(context, "Uspješno dodijeljen sudac");
    } on UserException catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Greška"),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }
}
