import 'package:ezscores_desktop/models/competitionsTeams.dart';
import 'package:ezscores_desktop/models/search_result.dart';
import 'package:ezscores_desktop/providers/CompetitionTeamsProvider.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTeamsToGroupDialog extends StatefulWidget {
  final int competitionId;
  final int groupId;

  const AddTeamsToGroupDialog({super.key, required this.competitionId, required this.groupId});

  @override
  State<AddTeamsToGroupDialog> createState() => _AddTeamsToGroupDialogState();
}

class _AddTeamsToGroupDialogState extends State<AddTeamsToGroupDialog> {
  late CompetitionTeamsProvider competitionTeamProvider;
  SearchResult<CompetitionsTeams>? competitionTeamsResult;
  final Set<int> _selectedTeamIds = {};

  @override
  void initState() {
    super.initState();
    competitionTeamProvider = context.read<CompetitionTeamsProvider>();
    initForm();
  }

  Future<void> initForm() async {
    var filter = {
      "competitionId": widget.competitionId,
      "onlyNullAndCurrentGroup" : true,
      "groupId" : widget.groupId
    };
    var data = await competitionTeamProvider.get(filter: filter);
    final preselected = data.result.where((ct)=>ct.groupId == widget.groupId && ct.id != null).map((ct)=>ct.id!).toSet();
    
    setState(() {
      competitionTeamsResult = data;
      _selectedTeamIds.addAll(preselected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Dodavanje timova u grupu"),
      content: SizedBox(
        width: 600,
        height: 500,
        child: _buildResultView(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Zatvori"),
        ),
        ElevatedButton(
        onPressed: () async => _save(),
        child: const Text("Spasi"),
      ),
      ],
    );
  }

  Widget _buildResultView() {
    if (competitionTeamsResult == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (competitionTeamsResult!.count == 0) {
      return const Center(child: Text('Nema podataka'));
    }

    return SingleChildScrollView(
      child: DataTable(
        columnSpacing: 16.0,
        showCheckboxColumn: true,
        columns: const [
          DataColumn(
            label: SizedBox(
              child: Text(
                "Naziv",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
        rows: competitionTeamsResult!.result
            .map(
              (e) {
                final competitionTeamId = e.id!;
                final isSelected = _selectedTeamIds.contains(competitionTeamId);
                return DataRow(
                selected: isSelected,
                onSelectChanged: (selected)
                {
                  setState(() {
                    if(selected == true)
                    {
                      _selectedTeamIds.add(e.id!);
                    }
                    else
                    {
                      _selectedTeamIds.remove(e.id!);
                    }
                  });
                },  
                cells: [
                  DataCell(
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: [
                        SizedBox(
                          width: 50,
                          child: e.team?.picture != null
                              ? imageFromString(e.team!.picture!)
                              : Image.asset('assets/images/team_placeholder.png',)
                        ),
                        const SizedBox(width: 20,),
                        Center(child: Text(e.team?.name ?? "-")),
                      ],)
                    ),
                  ),
                ],
              );
              }).toList(),
      ),
    );
  }
  
  _save() async {
    var request = {
      "groupId" : widget.groupId,
      "competitionId" : widget.competitionId,
      "competitionTeamIds" : _selectedTeamIds.toList()
    };
    try {
          await competitionTeamProvider.assignGroup(request);
          if(context.mounted)
          {
            showBottomRightNotification(context, "Uspješno ažurirana grupa!");
            Navigator.pop(context, true);
          }
        } on UserException catch (e) {
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
  
}
