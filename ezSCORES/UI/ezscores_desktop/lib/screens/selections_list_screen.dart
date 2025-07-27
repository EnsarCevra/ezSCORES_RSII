import 'package:ezscores_desktop/dialogs/selection_dialog.dart';
import 'package:ezscores_desktop/helpers/pagination/pagination_controller.dart';
import 'package:ezscores_desktop/helpers/pagination/pagination_controlls.dart';
import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/models/selections.dart';
import 'package:ezscores_desktop/providers/SelectionProvider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
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
  late PaginationController<Selections> _paginationController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectionProvider = context.read<SelectionProvider>();
  }

  @override
  void initState() {
    super.initState();
    selectionProvider = context.read<SelectionProvider>();
    _paginationController = PaginationController<Selections>(
      fetchPage: (page, pageSize){
        var filter = {
          "name": _ftsEditingController.text,
          "page": page,
          "pageSize": pageSize
        };
        return selectionProvider.get(filter: filter);
      }
    );
    initForm();
  }

  Future initForm() async {
    int currentPage = _paginationController.items.length < 2 && _paginationController.currentPage > 0 ? _paginationController.currentPage - 1 : _paginationController.currentPage;
    await _paginationController.loadPage(currentPage);
    setState(() {
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
            AnimatedBuilder(
              animation: _paginationController,
              builder: (context, _) => _buildResultView(),
            )
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
              await _paginationController.loadPage(0);
              setState(() {
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
  return Expanded(
    child: Column(
      children: [
        /// Main content area
        Expanded(
          child: _paginationController.isLoading
              ? const Center(child: CircularProgressIndicator())
              : _paginationController.items.isEmpty
                  ? const Center(child: Text('Nema podataka'))
                  : SingleChildScrollView(
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
                            DataColumn(
                              label: Text(
                                "",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                          rows: _paginationController.items.map((e) => DataRow(
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
                                  child: Center(child: Text(e.ageMax?.toString() ?? "-")),
                                ),
                              ),
                              DataCell(Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    tooltip: 'Obriši',
                                    onPressed: () async{
                                      await deleteEntity(context: context,
                                      deleteFunction: selectionProvider.delete,
                                      entityId: e.id!, 
                                      onDeleted: initForm);
                                    },)
                                )),
                            ],
                          )).toList(),
                        ),
                      ),
                    ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: PaginationControls(controller: _paginationController),
        ),
      ],
    ),
  );
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
