import 'package:ezscores_desktop/dialogs/stadium_dialog.dart';
import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/models/stadiums.dart';
import 'package:ezscores_desktop/models/search_result.dart';
import 'package:ezscores_desktop/providers/StadiumsProvider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StadiumsListScreen extends StatefulWidget {
  final int selectedIndex;
  const StadiumsListScreen({super.key, required this.selectedIndex});

  @override
  State<StadiumsListScreen> createState() => _StadiumsListScreenState();
}

class _StadiumsListScreenState extends State<StadiumsListScreen> {
  late StadiumProvider stadiumProvider;
  SearchResult<Stadiums>? stadiumResult;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stadiumProvider = context.read<StadiumProvider>();
  }

  @override
  void initState() {
    super.initState();
    stadiumProvider = context.read<StadiumProvider>();
    initForm();
  }

  Future initForm() async {
    var stadiumData = await stadiumProvider.get();
    setState(() {
      stadiumResult = stadiumData;
    });
  }

  final TextEditingController _ftsEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Lista stadiona",
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
              var data = await stadiumProvider.get(filter: filter);
              setState(() {
                stadiumResult = data;
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
    if (stadiumResult != null) {
      return stadiumResult!.count != 0
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
                    rows: stadiumResult?.result.map((e) => DataRow(
                          onSelectChanged: (_) => _handleRowTap(e),
                          cells: [
                            DataCell(
                                SizedBox(
                                  width: 30,
                                  child: e.picture != null ? imageFromString(e.picture!)
                                   : Icon(Icons.stadium)),
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

  _handleRowTap(Stadiums selectedStadium) async {
    final shouldReload = await showDialog<bool>(
      context: context,
      builder: (context) => StadiumDialog(stadium: selectedStadium),
    );

    if (shouldReload == true) {
      initForm();
    }
  }
}
