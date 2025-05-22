import 'dart:convert';
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
  late SponsorProvider sponsorProvider;
  late CompetitionsSponsorsProvider compeititonsSponsorsProvider;
  SearchResult<Sponsors>? sponsorResult;
  SearchResult<CompetitionsSponsors>? competitionSponsorResult; 
  Set<int?>? excludedSponsors;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    sponsorProvider = context.read<SponsorProvider>();
    compeititonsSponsorsProvider = context.read<CompetitionsSponsorsProvider>();
    super.initState();
    initForm();
  } 

  Future initForm() async{
    var filter = {
      "competitionId" : widget.competitionId
    };
    var sponsorData = await sponsorProvider.get();
    var competitionsSponsorsData = await compeititonsSponsorsProvider.get(filter: filter);
    setState(() {
      sponsorResult = sponsorData;
      competitionSponsorResult = competitionsSponsorsData;
      _excludeAssignedSponsors();
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
              var filter = {
                "name" : _nameController.text,
              };
              var data = await sponsorProvider.get(filter: filter);
              setState(() {
                sponsorResult = data;
                _excludeAssignedSponsors();
              });
            }, child: const Icon(Icons.search)),
          ],
        ),
    )
    );
  }
  
 _buildResultView() {
  if (sponsorResult != null) {
    return sponsorResult!.result.isNotEmpty
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
                      label: Flexible(child: Center(child: Text("Naziv", style: TextStyle(fontWeight: FontWeight.bold)))),
                    ),
                    DataColumn(
                      label: Flexible(child: Center(child: Text("Akcija", style: TextStyle(fontWeight: FontWeight.bold)))),
                    ),
                  ],
                  rows: sponsorResult!.result.map((e) {
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
                              _assignSponsor(e);
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
              child: Text('Nema dostupnih sponzora za dodavanje'),
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
        final sponsor = e.sponsor;

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
                child: sponsor?.picture != null
                    ? Image.memory(
                        base64Decode(sponsor!.picture!),
                        fit: BoxFit.contain, // or BoxFit.contain if you want full image fit
                      )
                    : const Icon(Icons.handshake, size: 40, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Text(
                sponsor?.name ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () async {
                  _removeSponsor(sponsor!.id!);
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

  void _assignSponsor(Sponsors selectedSponsor) async{
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
  
  void _excludeAssignedSponsors() {
    excludedSponsors = competitionSponsorResult!.result.map((e) => e.sponsorId).toSet();
    sponsorResult!.result = sponsorResult!.result.where((ref)=> !excludedSponsors!.contains(ref.id)).toList();
  }
}