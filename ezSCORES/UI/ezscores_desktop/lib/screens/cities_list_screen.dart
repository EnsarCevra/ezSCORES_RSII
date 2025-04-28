import 'package:ezscores_desktop/dialogs/city_dialog.dart';
import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/models/search_result.dart';
import 'package:ezscores_desktop/models/cities.dart';
import 'package:ezscores_desktop/providers/CitiesProvider.dart';
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
  SearchResult<Cities>? cityResult;

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
    initForm();
  }

  Future initForm() async {
    var cityData = await cityProvider.get();
    setState(() {
      cityResult = cityData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Lista gradova",
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
              var data = await cityProvider.get(filter: filter);
              setState(() {
                cityResult = data;
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
    if (cityResult != null) {
      return cityResult!.count != 0
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
                          width: 30,
                          child: Text(
                            "#",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Center(
                          child: Text(
                            "Naziv",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                      cityResult!.result.length,
                      (index) {
                        final city = cityResult!.result[index];
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
                          ],
                        );
                      },
                    ),
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
