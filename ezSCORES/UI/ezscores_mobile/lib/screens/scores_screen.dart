import 'package:ezscores_mobile/helpers/app_loading_widget.dart';
import 'package:ezscores_mobile/models/enums/gameStage.dart';
import 'package:ezscores_mobile/providers/utils.dart';
import 'package:ezscores_mobile/screens/match_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:ezscores_mobile/models/DTOs/fixtureDto.dart';
import 'package:ezscores_mobile/models/competitions.dart';
import 'package:ezscores_mobile/providers/FixturesProvider.dart';
import 'package:provider/provider.dart';

class ResultsScreen extends StatefulWidget {
  final Competitions competition;

  const ResultsScreen({super.key, required this.competition});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  List<FixtureDTO>? results;
  late FixtureProvider fixtureProvider;

  @override
  void initState() {
    super.initState();
    _loadFixtures();
  }

  void _loadFixtures() async {
    fixtureProvider = context.read<FixtureProvider>();
    var data = await fixtureProvider.getByCompetitionId(widget.competition.id!);
    setState(() {
      results = data;
    });
  }

@override
Widget build(BuildContext context) {
  if (results == null) {
    return const AppLoading();
  }
  final fixturesWithMatches = results!
    .where((fixture) => fixture.matches != null && fixture.matches!.isNotEmpty)
    .toList();

  return Scaffold(
    appBar: AppBar(
      title: Text(widget.competition.name ?? "Rezultati",
      style: const TextStyle(fontSize: 15),),
    ),
    body: ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: fixturesWithMatches.length,
      itemBuilder: (context, index) {
        final fixture = fixturesWithMatches[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Blue fixture header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade700,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                "${fixture.gameStage?.displayName ?? ""} "
                "• ${fixture.sequenceNumber! + 1}. kolo"
                "${fixture.isCompleted == true ? " • Kompletirano" : ""}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 6),

            /// Matches in this fixture
            _buildMatches(fixture),

            const SizedBox(height: 16), // spacing before next fixture
          ],
        );
      },
    ),
    bottomNavigationBar: Container(
        color: Colors.grey.shade200,
        padding: const EdgeInsets.all(8),
        child: SafeArea(
          child: Text(
            "${widget.competition.name} • ${widget.competition.season}",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ),
  );
}

  _buildMatches(FixtureDTO fixture) {
  return Column(
          children: fixture.matches!.map((match) {
            return InkWell(
              onTap: (){
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => MatchDetailsScreen(matchID: match.matchId, competition: widget.competition, fixtureId: fixture.id!,),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Match time
                    SizedBox(
                      width: 55,
                      child: Text(
                        "${formatDateOnly(match.dateAndTime)}\n${formatTimeOnly(match.dateAndTime)}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
              
                    const SizedBox(width: 12),
              
                    /// Teams with logos
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                color: Colors.grey.shade300,
                                margin: const EdgeInsets.only(right: 6),
                              ),
                              Expanded(
                                child: Text(
                                  match.homeTeam?.name ?? "?",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                color: Colors.grey.shade300,
                                margin: const EdgeInsets.only(right: 6),
                              ),
                              Expanded(
                                child: Text(
                                  match.awayTeam?.name ?? "?",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
              
                    /// Scores
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          match.isCompleted == true
                              ? "${match.homeTeamScore}"
                              : "-",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          match.isCompleted == true
                              ? "${match.awayTeamScore}"
                              : "-",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
}

}
