import 'dart:convert';

import 'package:ezscores_mobile/helpers/app_loading_widget.dart';
import 'package:ezscores_mobile/models/DTOs/fixtureDto.dart';
import 'package:ezscores_mobile/models/DTOs/matchDto.dart';
import 'package:ezscores_mobile/models/DTOs/playerDto.dart';
import 'package:ezscores_mobile/models/DTOs/refereeDto.dart';
import 'package:ezscores_mobile/models/DTOs/teamDto.dart';
import 'package:ezscores_mobile/models/enums/gameStage.dart';
import 'package:ezscores_mobile/providers/MatchesProvider.dart';
import 'package:ezscores_mobile/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MatchDetailsScreen extends StatefulWidget {
  int competitionId;
  String competitionName;
  String competitionSeason;
  int? matchID;
  FixtureDTO fixture;
  MatchDetailsScreen({super.key, required this.matchID, required this.fixture, required this.competitionId, required this.competitionName, required this.competitionSeason});

  @override
  State<MatchDetailsScreen> createState() => _MatchDetailsScreenState();
}

class _MatchDetailsScreenState extends State<MatchDetailsScreen> {
  late MatchesProvider matchesProvider;
   MatchDTO? match;
  
  @override
  void initState() {
    matchesProvider = context.read<MatchesProvider>();
    super.initState();
    initForm();
  }
  Future initForm() async {
    if (widget.matchID != null) {
      await _loadMatch(widget.matchID!);
    }
  }
  Future<void> _loadMatch(int matchID) async {
    match = await matchesProvider.getMatchDetails(matchID);
    match!.homeTeamScore = match!.goals!.where((e) => e.isHomeGoal == true).length;
    match!.awayTeamScore = match!.goals!.where((e) => e.isHomeGoal == false).length;
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    if(match == null)
    {
      return const AppLoading();
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalji utakmice",
        style: TextStyle(fontSize: 15),),
      ),
      body: _buildMatchDetails(),
      bottomNavigationBar: Container(
        color: Colors.grey.shade200,
        padding: const EdgeInsets.all(8),
        child: SafeArea(
          child: Text(
            "${widget.competitionName} • ${widget.competitionSeason}",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ),
    );
  }
  
  _buildMatchDetails() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          _buildHeader(),
          const Divider(),
          const TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(text: "Detalji"),
              Tab(text: "Tok meča"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildDetailsTab(),
                _buildStrikersTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  _buildHeader() {
    final bool isFinished = match?.isCompleted ?? false;
    final bool isUnderway = match?.isUnderway ?? false;

    // Main fixture info
    String fixtureInfo = widget.fixture.gameStage!.displayName;
    if (widget.fixture.gameStage == GameStage.league ||
        widget.fixture.gameStage == GameStage.groupPhase) {
      fixtureInfo += " • ${widget.fixture.sequenceNumber! + 1}. kolo";
    }
    if (widget.fixture.gameStage == GameStage.groupPhase) {
      fixtureInfo +=
          " • ${match?.group?.name}";
    }
    //Date and time
    final String dateTimeText = formatDateTime(match!.dateAndTime);
    // Score or VS
    final String centerText =
        (isFinished || isUnderway)
            ? "${match?.homeTeamScore ?? 0} : ${match?.awayTeamScore ?? 0}"
            : "VS";

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Fixture info
          if (fixtureInfo.isNotEmpty)
            Text(
              fixtureInfo,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          const SizedBox(height: 6),
          // Date & time
          if (dateTimeText.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 6),
                Text(
                  dateTimeText,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          const SizedBox(height: 14),
          // Stadium
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.stadium, size: 18),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  match?.stadium?.name ?? "—",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Teams and score / VS
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Home team
              _buildTeam(match?.homeTeam),
              const SizedBox(width: 12),
              // Center score or VS
              Text(
                centerText,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 12),
              // Away team
              _buildTeam(match?.awayTeam, isHome: false)
            ],
          ),
        ],
      ),
    );
  }
  _buildTeam(TeamDTO? team, {bool isHome = true}) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _teamLogo(team?.picture),
          const SizedBox(height: 4  ),
          Text(
            team?.name ?? "—",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
    Widget _teamLogo(String? base64Image) {
      if (base64Image != null && base64Image.isNotEmpty) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.memory(
            base64Decode(base64Image),
            width: 48,
            height: 48,
            fit: BoxFit.cover,
          ),
        );
      }
      return Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.image_not_supported, color: Colors.grey),
      );
    }
    
      _buildDetailsTab() {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeader("Sastav"),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildPlayersView(match?.homeTeam?.players, isHome: true),
                  _buildPlayersView(match?.awayTeam?.players, isHome: false),
                ]
              ),
              if(match?.referees?.isEmpty == false)_buildRefereesView(match?.referees),
            ],
          ),
        );
      }
      
        _buildStrikersTab() {
          if(match!.isCompleted == false && match!.isCompleted == false)
          {
            return const Center(child: Text("Meč još nije započeo"));
          }
          if(match!.goals!.isEmpty)
          {
            return const Center(child: Text("Meč nema pogodaka"));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: match!.goals!.map((goal) {
                final minute = goal.scoredAtMinute != null ? "${goal.scoredAtMinute}'" : "";
                final strikerText = goal.scorer != null
                    ? "⚽ $minute ${goal.scorer}"
                    : "⚽ $minute Nepoznat strijelac";
            
                final isLeft = goal.isHomeGoal ?? true;
            
                return Row(
                  mainAxisAlignment: isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 6.0),
                      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade600,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        strikerText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          );
        }

  _buildPlayersView(List<PlayerDTO>? players, {required bool isHome}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: isHome == true ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            ...players!.map(
              (player) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 15,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      player.name!,
                      textAlign: isHome ? TextAlign.start : TextAlign.end,
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }

  _buildRefereesView(List<RefereeDTO>? referees) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSubHeader("Sudije"),
        SizedBox(height: 10,),
        ...referees!.map(
            (referee) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Row(
                children: [
                  const Icon(
                    Icons.sports_soccer,
                    size: 15,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    referee.name!,
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
  
  _buildSubHeader(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
      color: Colors.blue,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );  
  }
}