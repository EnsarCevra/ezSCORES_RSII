import 'package:ezscores_desktop/dialogs/fixture_upsert_dialog.dart';
import 'package:ezscores_desktop/models/DTOs/fixtureDto.dart';
import 'package:ezscores_desktop/models/enums/competitionType.dart';
import 'package:ezscores_desktop/models/enums/gameStage.dart';
import 'package:ezscores_desktop/providers/FixturesProvider.dart';
import 'package:ezscores_desktop/providers/MatchesProvider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:ezscores_desktop/screens/match_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MatchesTab extends StatefulWidget {
  final int selectedIndex;
  final int competitionId;
  final CompetitionType competitionType;
  const MatchesTab({super.key, required this.competitionId, required this.competitionType, required this.selectedIndex});

  @override
  State<MatchesTab> createState() => _MatchesTabState();
}

class _MatchesTabState extends State<MatchesTab> {
  late FixtureProvider fixturesProvider;
  late MatchesProvider matchProvider;
  List<FixtureDTO>? fixtures;
  int? activeFixtureId;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fixturesProvider = context.read<FixtureProvider>();
    matchProvider = context.read<MatchesProvider>();
  }

  @override
  void initState() {
    super.initState();
    initForm();
  }

  Future initForm() async {
    fixturesProvider = context.read<FixtureProvider>();
    matchProvider = context.read<MatchesProvider>();
    var fixtureData = await fixturesProvider.getByCompetitionId(widget.competitionId);
    setState(() {
      fixtures = fixtureData;
      try {
        activeFixtureId = fixtures!.firstWhere((element) => element.isCurrentlyActive == true).id;
      } catch (e) {
        activeFixtureId = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (fixtures == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () async{
                  final actionResult = await showDialog<bool>(
                  context: context,
                  builder: (context) => FixtureDialog(competitionId: widget.competitionId, competitionType: widget.competitionType,),
                  );
                  if (actionResult == true) {
                    initForm();
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text("Dodaj kolo"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: fixtures!.length,
              itemBuilder: (context, index) {
                final fixture = fixtures![index];
                return Card(
                  color: fixture.isCurrentlyActive == true ? const Color.fromARGB(255, 180, 239, 182) : null,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${fixture.gameStage!.displayName} ${fixture.gameStage == GameStage.groupPhase || fixture.gameStage == GameStage.league ? '• ${fixture.sequenceNumber! + 1}. kolo' : ''} ${fixture.isCompleted == true ? '•  Kompletirano' : ''}',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Spacer(),  
                            if((activeFixtureId != null && fixture.id == activeFixtureId) || 
                                  (activeFixtureId == null && fixture.isCompleted == false))
                                Row(
                                children: [
                                  Text(fixture.isCurrentlyActive == true ? 'Deaktiviraj' : 'Aktiviraj' ),
                                  Switch(
                                    value: fixture.isCurrentlyActive ?? false,
                                    onChanged: (value) {
                                      _activateFixture(fixture.id!, value);
                                    },
                                  ),
                                ],
                              ),
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              tooltip: 'Uredi kolo',
                              onPressed: () async{
                                final actionResult = await showDialog<bool>(
                                context: context,
                                builder: (context) => FixtureDialog(competitionId: widget.competitionId, fixtureId: fixture.id, competitionType: widget.competitionType),
                                );
                                if (actionResult == true) {
                                  initForm();
                                }
                              },
                            ),
                            if(fixture.isCompleted != true && fixture.isCurrentlyActive == true) IconButton(
                              icon: const Icon(Icons.flag, color: Colors.orange),
                              tooltip: 'Završi kolo',
                              onPressed: () {
                                _finishFixture(fixture.id!);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              tooltip: 'Obriši kolo',
                              onPressed: () {
                                deleteEntity(
                                  context: context,
                                  deleteFunction: fixturesProvider.delete,
                                  entityId: fixture.id!,
                                  onDeleted: initForm);
                              },
                            ),
                            if(fixtureLimitReached(fixture)) ElevatedButton(onPressed: () async {
                              final actionResult = await Navigator.of(context).push(
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation, secondaryAnimation) => MatchDetailsScreen(fixture: fixture, competitionId: widget.competitionId,selectedIndex: widget.selectedIndex,),
                                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                          return FadeTransition(opacity: animation, child: child);
                                        },
                                      ),
                                    );

                                    if (actionResult == true) {
                                      initForm();
                                    }
                            }, child: const Text('Dodaj utakmicu')), 
                          ],
                        ),
                        const SizedBox(height: 8),
                        fixture.matches!.isEmpty
                            ? const Text('Nema utakmica u ovom kolu.')
                            : Column(
                                children: fixture.matches!.map((match) {
                                  return InkWell(
                                    onTap: () async{
                                      final actionResult = await Navigator.of(context).push(
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation, secondaryAnimation) => MatchDetailsScreen(matchID: match.matchId, fixture: fixture, competitionId: widget.competitionId,selectedIndex: widget.selectedIndex,),
                                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                          return FadeTransition(opacity: animation, child: child);
                                        },
                                      ),
                                    );

                                    if (actionResult == true) {
                                      initForm();
                                    }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(vertical: 6),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        border: Border.all(color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: SizedBox(
                                      height: 80,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          /// LEFT SIDE
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                if (match.gameStage == GameStage.groupPhase)
                                                  Text(
                                                    match.group!.name!,
                                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.grey),
                                                  ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  '${match.homeTeam?.name ?? "?"} vs ${match.awayTeam?.name ?? "?"}',
                                                  style: Theme.of(context).textTheme.titleMedium,
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  '${DateFormat('dd.MM.yyyy HH:mm').format(match.dateAndTime!)} • ${match.stadium?.name ?? ""}',
                                                  style: Theme.of(context).textTheme.bodySmall,
                                                ),
                                              ],
                                            ),
                                          ),

                                          /// RIGHT SIDE
                                          Center(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  match.isCompleted == true
                                                      ? '${match.homeTeamScore} : ${match.awayTeamScore}'
                                                      : '-',
                                                  style: Theme.of(context).textTheme.titleLarge,
                                                ),
                                                const SizedBox(width: 12),
                                                Container(
                                                  width: 1,
                                                  height: 40,
                                                  color: Colors.grey.shade300,
                                                ),
                                                const SizedBox(width: 12),
                                                IconButton(
                                                  icon: const Icon(Icons.delete, color: Colors.red),
                                                  tooltip: "Izbriši susret",
                                                  onPressed: () {
                                                    deleteEntity(
                                                      context: context,
                                                      deleteFunction: matchProvider.delete,
                                                      entityId: match.matchId!,
                                                      onDeleted: initForm
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    ),
                                  );
                                }).toList(),
                              ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  void _activateFixture(int fixtureId, bool status) async{
    try {
      await fixturesProvider.activateFixture(fixtureId, status);
      if(context.mounted)
      {
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
  
  void _finishFixture(int fixtureId) async{
    bool confirmed = await showConfirmDeleteDialog(context, content: 'Jeste li sigurni da želite završiti ovo kolo?', confirmMessage: "Završi");
    if(confirmed)
    {
      try {
      await fixturesProvider.finishFixture(fixtureId);
      if(context.mounted)
      {
        showBottomRightNotification(context, 'Kolo završeno');
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
  
  bool fixtureLimitReached(FixtureDTO fixture) {
    final limits = {
      GameStage.finals: 1,
      GameStage.semiFinals: 2,
      GameStage.quarterFinals: 4,
      GameStage.groupPhase: 9999,
      GameStage.league: 9999,
    };

    final limit = limits[fixture.gameStage] ?? 9999;
    final current = fixture.matches?.length ?? 0;

    return current < limit;
  }
}
