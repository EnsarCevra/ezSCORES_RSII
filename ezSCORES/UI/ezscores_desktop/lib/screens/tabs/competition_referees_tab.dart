import 'dart:convert';

import 'package:ezscores_desktop/helpers/pagination/pagination_controller.dart';
import 'package:ezscores_desktop/helpers/pagination/pagination_controlls.dart';
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
  late PaginationController<Referees> _paginationController;
  late RefereeProvider refereeProvider;
  late CompetitionsRefereesProvider competitionRefereeProvider;
  SearchResult<CompetitionsReferees>? competitionRefereeResult; 
  Set<int?>? excludedReferees;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    refereeProvider = context.read<RefereeProvider>();
    competitionRefereeProvider = context.read<CompetitionsRefereesProvider>();
    _paginationController = PaginationController<Referees>(
      fetchPage: (page, pageSize){
        var filter = {
          "competitionId" : widget.competitionId,
          "firstNameLastNameGTE" : _gteFirstLastNameEditingController.text,
          "page": page,
          "pageSize": pageSize
        };
        return refereeProvider.get(filter: filter);
      }
    );
    initForm();
  } 

  Future initForm() async{
    await _paginationController.loadPage();
    await _loadCompetitionReferees();
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
                        child: AnimatedBuilder(animation: _paginationController, builder: (context, _) => _buildResultView()),
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
              await _paginationController.loadPage(0);
              setState(() {
                _excludeAssignedReferees();
              });
            }, child: const Icon(Icons.search)),
          ],
        ),
    )
    );
  }
  
 Widget _buildResultView() {
  return Expanded(
    child: Column(
      children: [
        /// Main content area
        Expanded(
          child: _paginationController.isLoading
              ? const Center(child: CircularProgressIndicator())
              : _paginationController.items.isEmpty
                  ? const Center(child: Text('Nema dostupnih sudija za dodavanje'))
                  : SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8.0),
                        child: DataTable(
                          columnSpacing: 16.0,
                          showCheckboxColumn: false,
                          columns: const [
                            DataColumn(
                              label: Center(
                                child: Text("Slika", style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            DataColumn(
                              label: Center(
                                child: Text("Ime", style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            DataColumn(
                              label: Center(
                                child: Text("Prezime", style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            DataColumn(
                              label: Center(
                                child: Text("Akcija", style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                          rows: _paginationController.items.map((e) {
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
                                      await _assignReferee(e);
                                      await _paginationController.loadPage(_paginationController.currentPage);
                                      await _loadCompetitionReferees();
                                    },
                                    child: const Text("Dodijeli"),
                                  ),
                                ),
                              ),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
        ),

        /// Pagination controls pinned at bottom
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: PaginationControls(controller: _paginationController),
        ),
      ],
    ),
  );
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
        final competitionReferee = e;

        return Container(
          width: 200,
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
                backgroundImage: competitionReferee.referee?.picture != null
                    ? MemoryImage(base64Decode(competitionReferee.referee!.picture!))
                    : null,
                child: competitionReferee.referee?.picture == null
                    ? const Icon(Icons.account_circle, size: 50)
                    : null,
              ),
              const SizedBox(height: 10),
              Text(
                '${competitionReferee.referee?.firstName ?? ""} ${competitionReferee.referee?.lastName ?? ""}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () async {
                  _unassignReferee(competitionReferee.id!);
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

  Future<void> _assignReferee(Referees selectedReferee) async{
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
  void _excludeAssignedReferees() {
    excludedReferees = competitionRefereeResult!.result.map((e) => e.refereeId).toSet();
    _paginationController.items = _paginationController.items.where((ref)=> !excludedReferees!.contains(ref.id)).toList();
  }
  
  _loadCompetitionReferees() async {
    var filter = {
      "competitionId" : widget.competitionId
    };
    var competitionsRefereesData = await competitionRefereeProvider.get(filter: filter);
    setState(() {
      competitionRefereeResult = competitionsRefereesData;
      _excludeAssignedReferees();
    });
  }
}