import 'dart:convert';
import 'package:ezscores_desktop/helpers/pagination/pagination_controller.dart';
import 'package:ezscores_desktop/helpers/pagination/pagination_controlls.dart';
import 'package:ezscores_desktop/models/competitionsSponsors.dart';
import 'package:ezscores_desktop/models/search_result.dart';
import 'package:ezscores_desktop/models/sponsors.dart';
import 'package:ezscores_desktop/providers/CompetitionSponsorsProvider.dart';
import 'package:ezscores_desktop/providers/SponsorsProvider.dart';
import 'package:ezscores_desktop/providers/base_provider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompetitionsSponsorsTab extends StatefulWidget
{
  int competitionId;
  CompetitionsSponsorsTab({super.key, required this.competitionId});
  
  @override
  State<CompetitionsSponsorsTab> createState() => _CompetitionsSponsorsTabState();
}
class _CompetitionsSponsorsTabState extends State<CompetitionsSponsorsTab>
{
  late PaginationController<Sponsors> _paginationController;
  late SponsorProvider sponsorProvider;
  late CompetitionsSponsorsProvider compeititonsSponsorsProvider;
  SearchResult<CompetitionsSponsors>? competitionSponsorResult; 
  Set<int?>? excludedSponsors;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    sponsorProvider = context.read<SponsorProvider>();
    compeititonsSponsorsProvider = context.read<CompetitionsSponsorsProvider>();
    _paginationController = PaginationController<Sponsors>(
      fetchPage: (page, pageSize){
        var filter = {
          "name" : _nameController.text,
          "competitionId" : widget.competitionId,
          "page": page,
          "pageSize": pageSize
        };
        return sponsorProvider.get(filter: filter);
      }
    );
    initForm();
  } 

  Future initForm() async{
    await _paginationController.loadPage();
    await _loadCompetitionSponsors();
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
                          "Aktuelni sponzori",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: _buildAssignedSponsorsView(),
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
                          "Pretraži i dodijeli sponzore",
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
  final TextEditingController _nameController = TextEditingController();
  _buildSearch() {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Row(
          children: [
            Expanded(child: TextField(controller: _nameController, decoration: const InputDecoration(labelText: "Naziv"),)),
            const SizedBox(width: 8,),
            ElevatedButton(onPressed: () async{
              await _paginationController.loadPage(0);
              setState(() {
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
                  ? const Center(child: Text('Nema dostupnih sponzora za dodavanje'))
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
                                child: Text("Naziv", style: TextStyle(fontWeight: FontWeight.bold)),
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
                                                child: Icon(Icons.handshake, color: Colors.grey, size: 30),
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(Center(child: Text(e.name ?? ""))),
                              DataCell(
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await _assignSponsor(e);
                                      await _paginationController.loadPage(_paginationController.currentPage);
                                      await _loadCompetitionSponsors();
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

        /// Pagination controls always pinned to bottom
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: PaginationControls(controller: _paginationController),
        ),
      ],
    ),
  );
}


  
_buildAssignedSponsorsView() {
  if (competitionSponsorResult == null) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: double.infinity,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }

  final assignedSponsors = competitionSponsorResult!.result;

  if (assignedSponsors.isEmpty) {
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
      children: assignedSponsors.map((e) {
        final competitionSponsor = e;

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
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                clipBehavior: Clip.hardEdge,
                child: competitionSponsor.sponsor?.picture != null
                    ? Image.memory(
                        base64Decode(competitionSponsor.sponsor!.picture!),
                        fit: BoxFit.contain,
                      )
                    : const Icon(Icons.handshake, size: 40, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Text(
                competitionSponsor.sponsor?.name ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () async {
                  _removeSponsor(competitionSponsor.id!);
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

  Future<void> _assignSponsor(Sponsors selectedSponsor) async{
    var request = {
      "competitionId" : widget.competitionId,
      "sponsorId" : selectedSponsor.id
    };
    try {
          await compeititonsSponsorsProvider.insert(request);
          if(context.mounted)
          {
            showBottomRightNotification(context, "Uspješno dodan sponzor");
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
  
  void _removeSponsor(int id) async {
    try {
      await compeititonsSponsorsProvider.delete(id);
      if(context.mounted)
      {
        showBottomRightNotification(context, 'Sponzor uspješno uklonjen!');
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
  
  _loadCompetitionSponsors() async {
    var filter = {
      "competitionId" : widget.competitionId
    };
    var competitionsSponsorsData = await compeititonsSponsorsProvider.get(filter: filter);
    setState(() {
      competitionSponsorResult = competitionsSponsorsData;
    });
  }
}