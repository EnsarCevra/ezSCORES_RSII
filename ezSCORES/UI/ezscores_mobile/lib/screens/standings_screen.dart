import 'package:ezscores_mobile/models/DTOs/groupStandingsDto.dart';
import 'package:ezscores_mobile/models/DTOs/teamStandingsDto.dart';
import 'package:ezscores_mobile/models/competitions.dart';
import 'package:ezscores_mobile/models/enums/competitionStatus.dart';
import 'package:ezscores_mobile/models/enums/competitionType.dart';
import 'package:ezscores_mobile/providers/GroupsProvider.dart';
import 'package:ezscores_mobile/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StandingsScreen extends StatefulWidget {
  final Competitions competition;

  const StandingsScreen({
    super.key,
    required this.competition
  });

  @override
  State<StandingsScreen> createState() => _StandingsScreenState();
}

class _StandingsScreenState extends State<StandingsScreen> {
  List<GroupStandingsDTO>? groupStandings;
  late GroupProvider groupProvider;

  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  void _loadGroups() async {
    groupProvider = context.read<GroupProvider>();
    var data = await groupProvider.getGroupStandings(widget.competition.id!);
    setState(() {
      groupStandings = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (groupStandings == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.competition.name ?? "Poredak", style: const TextStyle(fontSize: 15),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 10,),
            Divider(
              height: 5,
              thickness: 0.5,
              color: Colors.grey.withOpacity(0.5),
            ),
            Expanded(child: widget.competition.competitionType == CompetitionType.league
            ? _buildLeagueTable(groupStandings!)
            : _buildTournamentGroups(groupStandings!))
          ],
        ),
      ),
    );
  }

  /// League → all teams in one table
  Widget _buildLeagueTable(List<GroupStandingsDTO> groups) {
  final allTeams = groups
      .expand((g) => g.standings ?? <TeamStandingsDTO>[])
      .cast<TeamStandingsDTO>()
      .toList();

  return SingleChildScrollView(
    padding: const EdgeInsets.all(12),
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tabela lige",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            _buildStandingsTable(null, allTeams),
          ],
        ),
      ),
    ),
  );
}


  /// Tournament → split by groups
  Widget _buildTournamentGroups(List<GroupStandingsDTO> groups) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.groupName ?? "Grupa ${group.groupId}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                _buildStandingsTable(null, group.standings ?? []),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Reusable standings table
  Widget _buildStandingsTable(String? title, List<TeamStandingsDTO> standings) {
  const tableTextStyle = TextStyle(fontSize: 12);

  return Center(
    child: DataTable(
      columnSpacing: 8,
      headingRowHeight: 28,
      dataRowHeight: 26,
      horizontalMargin: 8, // reduces left/right padding: VisualDensity.compact, // makes table denser
      columns: const [
        DataColumn(label: Text("Tim", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
        DataColumn(label: Text("U", style: tableTextStyle)),
        DataColumn(label: Text("P", style: tableTextStyle)),
        DataColumn(label: Text("N", style: tableTextStyle)),
        DataColumn(label: Text("I", style: tableTextStyle)),
        DataColumn(label: Text("+/-", style: tableTextStyle)),
        DataColumn(label: Text("B", style: tableTextStyle)),
      ],
      rows: standings.map((team) {
        return DataRow(
          cells: [
            DataCell(Text(team.teamName ?? "-", style: tableTextStyle)),
            DataCell(Text("${team.played ?? 0}", style: tableTextStyle)),
            DataCell(Text("${team.wins ?? 0}", style: tableTextStyle)),
            DataCell(Text("${team.draws ?? 0}", style: tableTextStyle)),
            DataCell(Text("${team.losses ?? 0}", style: tableTextStyle)),
            DataCell(Text("${team.goalsScored ?? 0}:${team.goalsConceded ?? 0}", style: tableTextStyle)),
            DataCell(Text("${team.points ?? 0}", style: tableTextStyle)),
          ],
        );
      }).toList(),
    ),
  );
}

  
  _buildHeader() {
    final textTheme = Theme.of(context).textTheme;
    return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                borderRadius: BorderRadius.circular(30), 
                child: Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey[300],
                            child: widget.competition.picture == null || widget.competition.picture!.isEmpty ?
                             const Icon(Icons.emoji_events, size: 30, color: Colors.grey) :
                             imageFromString(widget.competition.picture!)
                          )
                  ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.competition.name ?? '',
                        style: textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Organizator: ${widget.competition.city?.name ?? 'Nepoznato'}",
                        style: textTheme.bodyMedium
                            ?.copyWith(color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Status: ${widget.competition.status?.displayName}",
                        style: textTheme.bodySmall
                            ?.copyWith(color: Colors.blueGrey),
                      ),
                    ],
                  ),
                )
              ],
            );
  }
}
