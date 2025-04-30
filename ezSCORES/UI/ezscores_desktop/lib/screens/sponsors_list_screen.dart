import 'package:ezscores_desktop/dialogs/sponsor_dialog.dart';
import 'package:ezscores_desktop/dialogs/stadium_dialog.dart';
import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/models/sponsors.dart';
import 'package:ezscores_desktop/models/search_result.dart';
import 'package:ezscores_desktop/providers/SponsorsProvider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SponsorsListScreen extends StatefulWidget {
  final int selectedIndex;
  const SponsorsListScreen({super.key, required this.selectedIndex});

  @override
  State<SponsorsListScreen> createState() => _SponsorsListScreenState();
}

class _SponsorsListScreenState extends State<SponsorsListScreen> {
  late SponsorProvider sponsorProvider;
  SearchResult<Sponsors>? sponsorResult;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    sponsorProvider = context.read<SponsorProvider>();
  }

  @override
  void initState() {
    super.initState();
    sponsorProvider = context.read<SponsorProvider>();
    initForm();
  }

  Future initForm() async {
    var data = await sponsorProvider.get();
    setState(() {
      sponsorResult = data;
    });
  }

  final TextEditingController _ftsEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Lista sponzora",
      selectedIndex: widget.selectedIndex,
      Container(
        child: Column(
          children: [
            _buildSearch(),
            _buildResultView(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _ftsEditingController,
              decoration: const InputDecoration(labelText: "Naziv"),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () async {
              var filter = {
                "name": _ftsEditingController.text,
              };
              var data = await sponsorProvider.get(filter: filter);
              setState(() {
                sponsorResult = data;
              });
            },
            child: const Icon(Icons.search),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () async {
              final actionResult = await showDialog<bool>(
                context: context,
                builder: (context) => StadiumDialog());
              if (actionResult == true) {
                initForm();
              }
            },
            child: const Text("Dodaj"),
          ),
        ],
      ),
    );
  }

  Widget _buildResultView() {
    if (sponsorResult != null) {
      return sponsorResult!.count != 0
          ? Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  child: DataTable(
                    columnSpacing: 16.0,
                    showCheckboxColumn: false,
                    columns: [
                      DataColumn(
                          label: SizedBox(
                            child: Text(
                              "Slika",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ),
                      DataColumn(
                          label: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              "Naziv",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ),
                    ],
                    rows: sponsorResult?.result.map((e) => DataRow(
                          onSelectChanged: (_) => _handleRowTap(e),
                          cells: [
                            DataCell(
                                SizedBox(
                                  width: 30,
                                  child: e.picture != null ? imageFromString(e.picture!)
                                   : Icon(Icons.handshake)),
                            ),
                            DataCell(
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text(e.name ?? "")),
                              ),
                            ),
                          ],
                        ))
                        .toList()
                        .cast<DataRow>() ?? [],
                  ),
                ),
              ),
            )
          : const Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text('Nema podataka'),
              ),
            );
    } else {
      return const Expanded(
        child: Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  _handleRowTap(Sponsors selectedSponsor) async {
    final shouldReload = await showDialog<bool>(
      context: context,
      builder: (context) => SponsorDialog(sponsor: selectedSponsor),
    );

    if (shouldReload == true) {
      initForm();
    }
  }
}
