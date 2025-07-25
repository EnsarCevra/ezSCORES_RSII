import 'package:ezscores_desktop/dialogs/fixture_upsert_dialog.dart';
import 'package:ezscores_desktop/models/DTOs/fixtureDto.dart';
import 'package:ezscores_desktop/models/enums/gameStage.dart';
import 'package:ezscores_desktop/providers/FixturesProvider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:ezscores_desktop/screens/match_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MatchesTab extends StatefulWidget {
  final int competitionId;
  const MatchesTab({super.key, required this.competitionId});

  @override
  State<MatchesTab> createState() => _MatchesTabState();
}

class _MatchesTabState extends State<MatchesTab> {
  late FixtureProvider fixturesProvider;
  List<FixtureDTO>? fixtures;
  int? activeFixtureId;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fixturesProvider = context.read<FixtureProvider>();
  }

  @override
  void initState() {
    super.initState();
    initForm();
  }

  Future initForm() async {
    fixturesProvider = context.read<FixtureProvider>();
    var fixtureData = await fixturesProvider.getByCompetitionId(widget.competitionId);
    setState(() {
      fixtures = fixtureData;
      //nextInSequence = fixtures!.where((element) => element.isCurrentlyActive == true).first.sequenceNumber! + 1;
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
                  builder: (context) => FixtureDialog(competitionId: widget.competitionId,),
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
                              '${fixture.gameStage!.displayName} • ${fixture.sequenceNumber! + 1}. kolo ${fixture.isCompleted == true ? '•  Kompletirano' : ''}',
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
                                builder: (context) => FixtureDialog(competitionId: widget.competitionId, fixtureId: fixture.id,),
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
                                _deleteFixture(fixture.id!);
                              },
                            ),
                            if(fixtureLimitReached(fixture)) ElevatedButton(onPressed: () async {
                              final actionResult = await Navigator.of(context).push(
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation, secondaryAnimation) => MatchDetailsScreen(fixture: fixture, competitionId: widget.competitionId,),
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
                                        pageBuilder: (context, animation, secondaryAnimation) => MatchDetailsScreen(matchID: match.matchId, fixture: fixture, competitionId: widget.competitionId,),
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
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                if(match.gameStage == GameStage.groupPhase) Text(match.group!.name!),
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
                                          Text(
                                            '${match.isCompleted == true ? '${match.homeTeamScore} : ${match.awayTeamScore}' : '-'} ',
                                            style: Theme.of(context).textTheme.titleLarge,
                                          ),
                                        ],
                                      ),
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
  
  void _deleteFixture(int fixtureId) async{
    bool confirmed = await showConfirmDeleteDialog(context, content: 'Jeste li sigurni da želite izbrisati ovo kolo?\nSve utakmice iz ovog kola će također biti izbrisane!');
    if(confirmed)
    {
      try {
      await fixturesProvider.delete(fixtureId);
      if(context.mounted)
      {
        showBottomRightNotification(context, 'Grupa uspješno obrisana');
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
