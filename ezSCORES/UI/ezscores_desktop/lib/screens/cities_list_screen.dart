import 'package:ezscores_desktop/dialogs/city_dialog.dart';
import 'package:ezscores_desktop/helpers/pagination/pagination_controller.dart';
import 'package:ezscores_desktop/helpers/pagination/pagination_controlls.dart';
import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/models/search_result.dart';
import 'package:ezscores_desktop/models/cities.dart';
import 'package:ezscores_desktop/providers/CitiesProvider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CitiesListScreen extends StatefulWidget {
  final int selectedIndex;
  const CitiesListScreen({super.key, required this.selectedIndex});

  @override
  State<CitiesListScreen> createState() => _CitiesListScreenState();
}

class _CitiesListScreenState extends State<CitiesListScreen> {
  late CityProvider cityProvider;
  late PaginationController<Cities> _paginationController;

  final TextEditingController _ftsEditingController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cityProvider = context.read<CityProvider>();
  }

  @override
  void initState() {
    super.initState();
    cityProvider = context.read<CityProvider>();
    _paginationController = PaginationController<Cities>(
      fetchPage: (page, pageSize){
        var filter = {
          "name": _ftsEditingController.text,
          "page": page,
          "pageSize": pageSize
        };
        return cityProvider.get(filter: filter);
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

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Lista gradova",
      selectedIndex: widget.selectedIndex,
      Column(
        children: [
          _buildSearch(),
          AnimatedBuilder(animation: _paginationController, builder: (context, _) => _buildResultView(),),
        ],
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
                builder: (context) => CityDialog(),
              );
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
                          columns: [
                            DataColumn(
                              label: SizedBox(
                                width: 30,
                                child: Text(
                                  "#",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  "Naziv",
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                          rows: List<DataRow>.generate(
                            _paginationController.items.length,
                            (index) {
                              final city = _paginationController.items[index];
                              return DataRow(
                                onSelectChanged: (_) => _handleRowTap(city),
                                cells: [
                                  DataCell(
                                    SizedBox(
                                      width: 30,
                                      child: Center(child: Text((index + 1).toString())),
                                    ),
                                  ),
                                  DataCell(
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(city.name ?? ""),
                                    ),
                                  ),
                                  DataCell(Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      tooltip: 'Obriši',
                                      onPressed: () async{
                                        await deleteEntity(context: context,
                                        deleteFunction: cityProvider.delete,
                                        entityId: city.id!, 
                                        onDeleted: initForm);
                                      },)
                                  )),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
        ),

        /// Pagination controls at the bottom
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: PaginationControls(controller: _paginationController),
        ),
      ],
    ),
  );
}



  _handleRowTap(Cities selectedCity) async {
    final shouldReload = await showDialog<bool>(
      context: context,
      builder: (context) => CityDialog(city: selectedCity),
    );

    if (shouldReload == true) {
      initForm();
    }
  }
}
