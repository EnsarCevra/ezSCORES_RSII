import 'package:ezscores_desktop/providers/GroupsProvider.dart';
import 'package:flutter/material.dart';
import 'package:ezscores_desktop/models/DTOs/groupStandingsDto.dart';
import 'package:ezscores_desktop/models/DTOs/teamStandingsDto.dart';
import 'package:provider/provider.dart';

class StandingsTab extends StatefulWidget {
  final int competitionId;
  final bool isLeague;

  const StandingsTab({
    super.key,
    required this.competitionId,
    required this.isLeague,
  });

  @override
  State<StandingsTab> createState() => _StandingsTabState();
}

class _StandingsTabState extends State<StandingsTab> {
  List<GroupStandingsDTO>? groupStandings;
  late GroupProvider groupProvider;


  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  void _loadGroups() async {
    groupProvider = context.read<GroupProvider>();
    var data = await groupProvider.getGroupStandings(widget.competitionId);
    setState(() {
      groupStandings = data;
    });
  }

  // Future<List<GroupStandingsDTO>> _fetchGroupStandings() async {
  //   // Replace this with your actual provider method
  //   final provider = GroupProvider();
  //   // You may need to call something like:
  //   // final ids = await provider.getGroupIds(widget.competitionId);
  //   // then fetch group standings for each

  //   // Simulated: just fetch one group for the example
  //   final group = await provider.getGroupStandings(widget.competitionId);
  //   return [group]; // Adjust this if multiple groups returned
  // }

  @override
  Widget build(BuildContext context) {
    if(groupStandings != null)
    {
      return widget.isLeague
            ? _buildLeagueTable(groupStandings!)
            : _buildTournamentGroups(groupStandings!);
    }
    else
    {
      return Container(
        height: MediaQuery.of(context).size.height * 0.7,
        width: double.infinity,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      );
    }
  }

  Widget _buildLeagueTable(List<GroupStandingsDTO> groups) {
    final allTeams = groups.expand((g) => g.standings ?? <TeamStandingsDTO>[]).cast<TeamStandingsDTO>().toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: _buildStandingsTable("Tabela lige", allTeams),
    );
  }

  Widget _buildTournamentGroups(List<GroupStandingsDTO> groups) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        GridView.builder(
          shrinkWrap: true, // Important!
          physics: const NeverScrollableScrollPhysics(), // Prevent double scroll
          itemCount: groups.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.3,
          ),
          itemBuilder: (context, index) {
            final group = groups[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.groupName ?? "Grupa ${group.groupId}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 220, // Set a fixed height for the table
                      child: SingleChildScrollView(
                        child: _buildStandingsTable(null, group.standings ?? []),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () {
            // show add group dialog
          },
          icon: const Icon(Icons.add),
          label: const Text("Dodaj grupu"),
        ),
      ],
    ),
  );
}


  Widget _buildStandingsTable(String? title, List<TeamStandingsDTO> standings) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 24, // More space between columns
        headingRowHeight: 40,
        dataRowHeight: 36,
        columns: const [
          DataColumn(label: Text("Tim")),
          DataColumn(label: Text("U")),
          DataColumn(label: Text("P")),
          DataColumn(label: Text("N")),
          DataColumn(label: Text("I")),
          DataColumn(label: Text("+/-")),
          DataColumn(label: Text("B")),
        ],
        rows: standings.map((team) {
          return DataRow(cells: [
            DataCell(Text(team.teamName ?? "-")),
            DataCell(Text("${team.played ?? 0}")),
            DataCell(Text("${team.wins ?? 0}")),
            DataCell(Text("${team.draws ?? 0}")),
            DataCell(Text("${team.losses ?? 0}")),
            DataCell(Text(team.goalDifference != null ? "${team.goalsScored}" ":" "${team.goalsConceded}": "")),
            DataCell(Text("${team.points ?? 0}")),
          ]);
        }).toList(),
      ),
    ),
  );
}
// "${applicant?.firstName ?? '-'} ${applicant?.lastName ?? '-'}"),
}
