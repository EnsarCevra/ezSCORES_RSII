import 'package:ezscores_desktop/dialogs/selection_dialog.dart';
import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/models/search_result.dart';
import 'package:ezscores_desktop/models/selections.dart';
import 'package:ezscores_desktop/providers/SelectionProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectionsListScreen extends StatefulWidget {
  final int selectedIndex;
  const SelectionsListScreen({super.key, required this.selectedIndex});

  @override
  State<SelectionsListScreen> createState() => _SelectionsListScreenState();
}

class _SelectionsListScreenState extends State<SelectionsListScreen> {
  late SelectionProvider selectionProvider;
  SearchResult<Selections>? selectionResult;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectionProvider = context.read<SelectionProvider>();
  }

  @override
  void initState() {
    super.initState();
    selectionProvider = context.read<SelectionProvider>();
    initForm();
  }

  Future initForm() async {
    var selectionData = await selectionProvider.get();
    setState(() {
      selectionResult = selectionData;
    });
  }

  final TextEditingController _ftsEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Lista selekcija",
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
              var data = await selectionProvider.get(filter: filter);
              setState(() {
                selectionResult = data;
              });
            },
            child: const Icon(Icons.search),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () async {
              final actionResult = await showDialog<bool>(
                context: context,
                builder: (context) => SelectionDialog());
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
    if (selectionResult != null) {
      return selectionResult!.count != 0
          ? Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  child: DataTable(
                    columnSpacing: 16.0,
                    showCheckboxColumn: false,
                    columns: const [
                      DataColumn(
                        label: Flexible(
                          child: Center(
                            child: Text(
                              "Naziv",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Flexible(
                          child: Center(
                            child: Text(
                              "Max. Godine",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                    rows: selectionResult?.result.map((e) => DataRow(
                          onSelectChanged: (_) => _handleRowTap(e),
                          cells: [
                            DataCell(
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text(e.name ?? "")),
                              ),
                            ),
                            DataCell(
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text(e.ageMax?.toString() ?? "")),
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

  _handleRowTap(Selections selectedSelection) async {
    final shouldReload = await showDialog<bool>(
    context: context,
    builder: (context) => SelectionDialog(selection: selectedSelection),
    );

    if (shouldReload == true) {
      initForm();
    }
  }
}
