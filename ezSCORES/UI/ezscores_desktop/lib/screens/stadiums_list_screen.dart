import 'package:ezscores_desktop/dialogs/stadium_dialog.dart';
import 'package:ezscores_desktop/helpers/pagination/pagination_controller.dart';
import 'package:ezscores_desktop/helpers/pagination/pagination_controlls.dart';
import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/models/stadiums.dart';
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
  late PaginationController<Stadiums> _paginationController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stadiumProvider = context.read<StadiumProvider>();
  }

  @override
  void initState() {
    super.initState();
    stadiumProvider = context.read<StadiumProvider>();
    _paginationController = PaginationController<Stadiums>(
      fetchPage: (page, pageSize){
        var filter = {
          "name": _ftsEditingController.text,
          "page": page,
          "pageSize": pageSize
        };
        return stadiumProvider.get(filter: filter);
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
      "Lista stadiona",
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
  return Expanded(
    child: Column(
      children: [
        // Main content area
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
                              label: Center(
                                  child: Text(
                                    "Slika",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                            ),
                            DataColumn(
                              label: Text(
                                    "Naziv",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  )
                            ),
                            DataColumn(
                              label: Text(
                                "",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                          rows: _paginationController.items.map((e) {
                            return DataRow(
                              onSelectChanged: (_) => _handleRowTap(e),
                              cells: [
                                DataCell(
                                  SizedBox(
                                    width: 30,
                                    child: e.picture != null
                                        ? imageFromString(e.picture!)
                                        : const Icon(Icons.stadium),
                                  ),
                                ),
                                DataCell(
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(e.name ?? ""),
                                  ),
                                ),
                                DataCell(Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    tooltip: 'Obriši',
                                    onPressed: () async{
                                      await deleteEntity(context: context,
                                      deleteFunction: stadiumProvider.delete,
                                      entityId: e.id!, 
                                      onDeleted: initForm);
                                    },)
                                )),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
        ),

        // Pagination controls pinned at bottom
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: PaginationControls(controller: _paginationController),
        ),
      ],
    ),
  );
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
