import 'dart:convert';

import 'package:ezscores_desktop/models/competitionsReferees.dart';
import 'package:ezscores_desktop/models/referees.dart';
import 'package:ezscores_desktop/models/search_result.dart';
import 'package:ezscores_desktop/providers/CompetitionRefereeProvider.dart';
import 'package:ezscores_desktop/providers/RefereesProvider.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompetitionRefereesTab extends StatefulWidget
{
  int competitionId;
  CompetitionRefereesTab({super.key, required this.competitionId});
  
  @override
  State<CompetitionRefereesTab> createState() => _CompetitionRefereesTabState();
}
class _CompetitionRefereesTabState extends State<CompetitionRefereesTab>
{
  late RefereeProvider refereeProvider;
  late CompetitionsRefereesProvider competitionRefereeProvider;
  SearchResult<Referees>? refereeResult;
  SearchResult<CompetitionsReferees>? competitionRefereeResult; 
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    refereeProvider = context.read<RefereeProvider>();
    competitionRefereeProvider = context.read<CompetitionsRefereesProvider>();
    super.initState();
    initForm();
  } 

  Future initForm() async{
    var filter = {
      "competitionId" : widget.competitionId
    };
    var refereeData = await refereeProvider.get();
    var competitionsRefereesData = await competitionRefereeProvider.get(filter: filter);
    final excludedRefereeIds = competitionsRefereesData.result.map((e) => e.refereeId).toSet();
    refereeData.result = refereeData.result.where((ref)=> !excludedRefereeIds.contains(ref.id)).toList();
    setState(() {
      refereeResult = refereeData;
      competitionRefereeResult = competitionsRefereesData;
    });
   }


   @override
  Widget build(BuildContext context)
  {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // Left side - Assigned Referees
                Expanded(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Dodijeljeni sudci",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: _buildAssignedRefereesView(),
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(width: 1, thickness: 1),
                // Right side - Search Results
                Expanded(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Pretraži i dodijeli sudce",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      _buildSearch(),
                      Expanded(
                        child: _buildResultView(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  final TextEditingController _gteFirstLastNameEditingController = TextEditingController();
  _buildSearch() {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Row(
          children: [
            Expanded(child: TextField(controller: _gteFirstLastNameEditingController, decoration: const InputDecoration(labelText: "Ime/prezime"),)),
            const SizedBox(width: 8,),
            ElevatedButton(onPressed: () async{
              var filter = {
                "firstNameLastNameGTE" : _gteFirstLastNameEditingController.text,
              };
              var data = await refereeProvider.get(filter: filter);
              setState(() {
                refereeResult = data;
              });
            }, child: const Icon(Icons.search)),
          ],
        ),
    )
    );
  }
  
 _buildResultView() {
  if (refereeResult != null) {
    return refereeResult!.result.isNotEmpty
        ? SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: DataTable(
                  columnSpacing: 16.0,
                  showCheckboxColumn: false,
                  columns: const [
                    DataColumn(
                      label: Flexible(child: Center(child: Text("Slika", style: TextStyle(fontWeight: FontWeight.bold)))),
                    ),
                    DataColumn(
                      label: Flexible(child: Center(child: Text("Ime", style: TextStyle(fontWeight: FontWeight.bold)))),
                    ),
                    DataColumn(
                      label: Flexible(child: Center(child: Text("Prezime", style: TextStyle(fontWeight: FontWeight.bold)))),
                    ),
                    DataColumn(
                      label: Flexible(child: Center(child: Text("Dodaj", style: TextStyle(fontWeight: FontWeight.bold)))),
                    ),
                  ],
                  rows: refereeResult!.result.map((e) {
                    return DataRow(cells: [
                      DataCell(
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: e.picture != null
                                    ? imageFromString(e.picture!)
                                    : const CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Icon(Icons.account_circle, color: Colors.grey, size: 30),
                                  ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      DataCell(Center(child: Text(e.firstName ?? ""))),
                      DataCell(Center(child: Text(e.lastName ?? ""))),
                      DataCell(
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              _assignReferee(e);
                              initForm();
                            },
                            child: const Text("Dodijeli"),
                          ),
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              ),
            )
        : const Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text('Nema dostupnih sudija za dodavanje'),
            ),
          );
  } else {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: double.infinity,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}

  
_buildAssignedRefereesView() {
  if (competitionRefereeResult == null) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: double.infinity,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }

  final assignedReferees = competitionRefereeResult!.result;

  if (assignedReferees.isEmpty) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text("Nema dodijeljenih sudija."),
    );
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Wrap(
      spacing: 16,
      runSpacing: 16,
      children: assignedReferees.map((e) {
        final referee = e.referee;

        return Container(
          width: 150,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade300,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(2, 2),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                backgroundImage: referee?.picture != null
                    ? MemoryImage(base64Decode(referee!.picture!))
                    : null,
                child: referee?.picture == null
                    ? const Icon(Icons.account_circle, size: 50)
                    : null,
              ),
              const SizedBox(height: 10),
              Text(
                '${referee?.firstName ?? ""} ${referee?.lastName ?? ""}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () async {
                  _unassignReferee(referee!.id!);
                },
                icon: const Icon(Icons.remove_circle_outline),
                label: const Text("Ukloni"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                ),
              )
            ],
          ),
        );
      }).toList(),
    ),
  );
}

  void _assignReferee(Referees selectedReferee) async{
    var request = {
      "competitionId" : widget.competitionId,
      "refereeId" : selectedReferee.id
    };
    try {
          await competitionRefereeProvider.insert(request);
          if(context.mounted)
          {
            showBottomRightNotification(context, "Uspješno dodijeljen sudac");
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
  
  void _unassignReferee(int id) async {
    try {
      await competitionRefereeProvider.delete(id);
      if(context.mounted)
      {
        showBottomRightNotification(context, 'Sudac uspješno uklonjen!');
        initForm(); 
      }
    } catch (e) {
        showDialog(
          context: context, 
          builder: (context) => AlertDialog(
          title: const Text("Error"), 
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("Ok"))], 
          content: Text(e.toString()),));
      }                  // Refresh
  }
}