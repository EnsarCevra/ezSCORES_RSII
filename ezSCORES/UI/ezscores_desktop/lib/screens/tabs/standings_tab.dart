import 'package:ezscores_desktop/dialogs/add_teams_to_group_dialog.dart';
import 'package:ezscores_desktop/providers/GroupsProvider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            onPressed: () {
              _showAddGroupDialog(context, groups.length, null);
            },
            icon: const Icon(Icons.add),
            label: const Text("Dodaj grupu"),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: double.infinity),
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: groups.map((group) {
                return SizedBox(
                  width: 400, // still control card width manually
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                group.groupName ?? "Grupa ${group.groupId}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.add, color: Colors.grey),
                                    onPressed: () async {
                                      final shouldReload = await showDialog<bool>(
                                        context: context,
                                        builder: (context) => AddTeamsToGroupDialog(
                                          competitionId: widget.competitionId,
                                          groupId: group.groupId!,
                                        ),
                                      );

                                      if (shouldReload == true) {
                                        _loadGroups();
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () {
                                      _showAddGroupDialog(context, null, group);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete_forever_outlined, color: Colors.red),
                                    onPressed: () {
                                      deleteEntity(
                                        context: context,
                                        deleteFunction: groupProvider.delete,
                                        entityId: group.groupId!,
                                        onDeleted: _loadGroups,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _buildStandingsTable(null, group.standings ?? []), // <-- removed fixed height & scroll
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    ),
  );
}




  Widget _buildStandingsTable(String? title, List<TeamStandingsDTO> standings) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(8),
    child: DataTable(
      columnSpacing: 24,
      headingRowHeight: 40,
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
    );
  }
    void _showAddGroupDialog(BuildContext context, int? indeks, GroupStandingsDTO? selectedGroup) {
    final TextEditingController _controller = TextEditingController();
    String? errorText;
    if(selectedGroup == null)
    {
      _controller.text = 'Grupa ${String.fromCharCode(65+indeks!)}';
    }
    else
    {
      _controller.text = selectedGroup.groupName!;
    }
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(selectedGroup == null ? "Dodaj novu grupu" : "Uredi grupu"),
              content: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: "Naziv grupe",
                  errorText: errorText,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Otkaži"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final name = _controller.text.trim();
                    final regex = RegExp(r'^[a-zA-ZčćžšđČĆŽŠĐ\s]+$');
                    if (name.isEmpty) {
                      setState(() {
                        errorText = "Naziv grupe je obavezan.";
                      });
                      return;
                    }
                    if (!regex.hasMatch(name)) {
                      setState(() {
                        errorText = "Naziv grupe smije sadržavati\nsamo slova i razmake.";
                      });
                      return;
                    }
                    var request = {
                      "competitionId" : widget.competitionId,
                      "name" : name
                    };

                    try {
                      if(selectedGroup == null)
                      {
                        await groupProvider.insert(request);
                      }
                      else
                      {
                        await groupProvider.update(selectedGroup.groupId!, request);
                      }
                      if(context.mounted)
                      {
                        showBottomRightNotification(context, selectedGroup == null ?  'Grupa kreirana' : 'Grupa uspješno ažurirana');
                        _loadGroups();
                        Navigator.pop(context, true);
                      }
                    } catch (e) {
                      showDialog(
                        context: context, 
                        builder: (context) => AlertDialog(
                        title: Text("Error"), 
                        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("Ok"))], 
                        content: Text(e.toString()),));
                    }
                  },
                  child: Text(selectedGroup == null ?  'Dodaj' : 'Spasi'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
