import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/models/cities.dart';
import 'package:ezscores_desktop/models/competitions.dart';
import 'package:ezscores_desktop/models/enums/competitionStatus.dart';
import 'package:ezscores_desktop/models/enums/competitionType.dart';
import 'package:ezscores_desktop/models/search_result.dart';
import 'package:ezscores_desktop/models/selections.dart';
import 'package:ezscores_desktop/providers/CitiesProvider.dart';
import 'package:ezscores_desktop/providers/CompetitionsProvider.dart';
import 'package:ezscores_desktop/providers/SelectionProvider.dart';
import 'package:ezscores_desktop/providers/auth_provider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:ezscores_desktop/screens/tournament_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class CompetitionsListScreen extends StatefulWidget
{
  final int selectedIndex;
  const CompetitionsListScreen({super.key, required this.selectedIndex});
  
  @override
  State<StatefulWidget> createState() => _CompetitionListScreenState();
}
class _CompetitionListScreenState extends State<CompetitionsListScreen>
{
  late CompetitionProvider competitionProvider;
  late CityProvider cityProvider;
  late SelectionProvider selectionProvider;

  String? _lastSelectedCityName = null;
  Cities? _selectedCity = null;
  String? selectedSelectionID;
  int? selectedStatus;
  int? selectedCompetitionType;
  SearchResult<Competitions>? competitionResult = null; 
  SearchResult<Selections>? selectionResult = null; 
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  void initState() {
    competitionProvider = context.read<CompetitionProvider>();
    cityProvider = context.read<CityProvider>();
    selectionProvider = context.read<SelectionProvider>();

    super.initState();
    _cityController.addListener((){
      if (_lastSelectedCityName != null &&
        _cityController.text != _lastSelectedCityName) {
      setState(() {
        _selectedCity = null;
        _lastSelectedCityName = null;
        });
      }
    });
    initForm();
  }
 

  Future initForm() async{
    var filter = {"isSelectionIncluded" : true, "isCityIncluded" : true};
    if(AuthProvider.roleID == 1)
    {
      filter['onlyUserCompettions'] = true;
    }
    var playerData = await competitionProvider.get(filter: filter);
    var selectionData = await selectionProvider.get();
    setState(() {
      competitionResult = playerData;
      selectionResult = selectionData;
    });
   }
   @override
    void dispose() {
      _horizontalScrollController.dispose();
      super.dispose();
    }

   @override
  Widget build(BuildContext context)
  {
    return MasterScreen("Lista takmičenja", selectedIndex: widget.selectedIndex,
    Container(
      child: Column(
        children: [
          _buildSearch(),
          _buildResultView()
        ],
      ),
    ));
  }
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  // final TextEditingController _dateController = TextEditingController();
Widget _buildSearch() {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: FormBuilder(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _nameEditingController,
                  decoration: InputDecoration(labelText: "Naziv"),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: buildCityTypeAheadField(
                context: context,
                name: "city",
                controller: _cityController,
                selectedCity: _selectedCity,
                isRequired: false,
                onChanged: (city) {
                  setState(() {
                    _selectedCity = city;
                  });
                },
              ),
              ),
            ],
          ),
          SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: FormBuilderDropdown(
                  name: "selectionId",
                  decoration: InputDecoration(
                    labelText: "Selekcija",
                    suffixIcon: selectedSelectionID != "null" && selectedSelectionID != null
                        ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _formKey.currentState
                                    ?.fields['selectionId']
                                    ?.reset();
                                selectedSelectionID = null;
                              });
                            },
                          )
                        : null,
                    ),
                  focusColor: Colors.transparent,
                  items: 
                    selectionResult?.result.map(
                      (item) => DropdownMenuItem(
                        value: item.id.toString(),
                        child: Text(item.name ?? ""),
                      ),
                    ).toList() ?? [],
                  onChanged: (value) {
                    setState(() {
                      selectedSelectionID = value.toString();
                    });
                  },
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: FormBuilderDropdown<int>(
                  name: 'competitionStatus',
                  decoration: InputDecoration(
                    labelText: 'Status',
                    suffixIcon: selectedStatus != null
                        ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                selectedStatus = null;
                                _formKey.currentState
                                    ?.fields['competitionStatus']
                                    ?.reset();
                              });
                            },
                          )
                        : null,
                  ),
                  focusColor: Colors.transparent,
                  items: CompetitionStatus.values
                      .map((status) => DropdownMenuItem<int>(
                            value: status.value,
                            child: Text(status.displayName),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value;
                    });
                  },
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: FormBuilderDropdown<int>(
                  name: 'competitionType',
                  decoration: InputDecoration(
                    labelText: 'Tip/Vrsta',
                    suffixIcon: selectedCompetitionType != null
                        ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                selectedCompetitionType = null;
                                _formKey.currentState
                                    ?.fields['competitionType']
                                    ?.reset();
                              });
                            },
                          )
                        : null,
                  ),
                  focusColor: Colors.transparent,
                  items: CompetitionType.values
                      .map((type) => DropdownMenuItem<int>(
                            value: type.value,
                            child: Text(type.displayName),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCompetitionType = value;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  var filter = {
                    "name": _nameEditingController.text,
                    "cityId": _selectedCity?.id,
                    "isSelectionIncluded": true,
                    "status": selectedStatus,
                    "competitionType" : selectedCompetitionType,
                    "selectionId": selectedSelectionID
                  };
                  var data = await competitionProvider.get(filter: filter);
                  setState(() {
                    competitionResult = data;
                  });
                },
                child: Icon(Icons.search),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () async {
                  final actionResult = await Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => CompetitionsDetailsScreen(selectedIndex: widget.selectedIndex),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                    ),
                  );
                  if (actionResult == true) {
                    initForm();
                  }
                },
                child: Text("Dodaj"),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

final ScrollController _horizontalScrollController = ScrollController();
Widget _buildResultView() {
  if (competitionResult != null) {
    if (competitionResult!.count != 0) {
      return Expanded( // This allows vertical scrolling within available space
        child: Scrollbar(
          controller: _horizontalScrollController,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: _horizontalScrollController,
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                ),
                child: DataTable(
                  columnSpacing: 16.0,
                  showCheckboxColumn: false,
                  columns: const [
                    DataColumn(label: Flexible(child: Center(child: Text("Slika", style: TextStyle(fontWeight: FontWeight.bold))))),
                    DataColumn(label: Flexible(child: Center(child: Text("Naziv", style: TextStyle(fontWeight: FontWeight.bold))))),
                    DataColumn(label: Flexible(child: Center(child: Text("Tip", style: TextStyle(fontWeight: FontWeight.bold))))),
                    DataColumn(label: Flexible(child: Center(child: Text("Status", style: TextStyle(fontWeight: FontWeight.bold))))),
                    DataColumn(label: Flexible(child: Center(child: Text("Selekcija/uzrast", style: TextStyle(fontWeight: FontWeight.bold))))),
                    DataColumn(label: Flexible(child: Center(child: Text("Prijave do", style: TextStyle(fontWeight: FontWeight.bold))))),
                    DataColumn(label: Flexible(child: Center(child: Text("Početak takmičenja", style: TextStyle(fontWeight: FontWeight.bold))))),
                  ],
                  rows: competitionResult?.result.map((e) => DataRow(
                    onSelectChanged: (_) => _handleRowTap(e),
                    cells: [
                      DataCell(Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: e.picture != null
                                  ? imageFromString(e.picture!)
                                  : Icon(Icons.sports_soccer),
                            ),
                          ),
                        ),
                      )),
                      DataCell(Center(child: Text(e.name ?? ""))),
                      DataCell(Center(child: Text(e.competitionType?.displayName ?? '-'))),
                      DataCell(Center(child: Text(e.status?.displayName ?? '-'))),
                      DataCell(Center(child: Text(e.selection?.name ?? '-'))),
                      DataCell(Center(child: Text(formatDateOnly(e.applicationEndDate)))),
                      DataCell(Center(child: Text(formatDateOnly(e.startDate)))),
                    ],
                  )).toList() ?? [],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return const Expanded(
        child: Align(
          alignment: Alignment.center,
          child: Text('Nema podataka'),
        ),
      );
    }
  } else {
    return const Expanded(
      child: Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}


  
  _handleRowTap(Competitions selectedCompetition) async{
    final actionResult = await Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => CompetitionsDetailsScreen(selectedIndex: widget.selectedIndex, competition: selectedCompetition,),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    ),
  );

  if (actionResult == true) {
    initForm();
  }
  }
  
  // Future<void> _pickDate(BuildContext context) async{
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: _selectedDate ?? DateTime.now(),
  //      firstDate: DateTime(DateTime.now().year - 70), 
  //      lastDate: DateTime.now()
  //     );
  //   if(picked != null)
  //   {
  //     setState(() {
  //       _selectedDate = picked;
  //       _dateController.text = DateFormat('dd.MM.yyyy').format(picked);
  //     });
  //   }
  // }
}