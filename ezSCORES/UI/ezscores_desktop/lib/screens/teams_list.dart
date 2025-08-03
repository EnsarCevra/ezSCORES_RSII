import 'package:ezscores_desktop/helpers/pagination/pagination_controller.dart';
import 'package:ezscores_desktop/helpers/pagination/pagination_controlls.dart';
import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/models/search_result.dart';
import 'package:ezscores_desktop/models/selections.dart';
import 'package:ezscores_desktop/models/teams.dart';
import 'package:ezscores_desktop/providers/SelectionProvider.dart';
import 'package:ezscores_desktop/providers/TeamProvider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:ezscores_desktop/screens/teams_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class TeamsListScreen extends StatefulWidget
{
  final int selectedIndex;
  const TeamsListScreen({super.key, required this.selectedIndex});

  @override
  State<TeamsListScreen> createState() => _TeamsListScreenState();
}

class _TeamsListScreenState extends State<TeamsListScreen> {
  late TeamProvider teamProvider;
  late SelectionProvider selectionProvider;
  SearchResult<Selections>? selectionResult;
  late PaginationController<Teams> _paginationController;
   @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();
    teamProvider = context.read<TeamProvider>();
  }
  @override
  void initState() {
    super.initState();
    teamProvider = context.read<TeamProvider>();
    selectionProvider = context.read<SelectionProvider>();
    _paginationController = PaginationController<Teams>(
      fetchPage: (page, pageSize){
        var filter = {
          "name": _ftsEditingController.text,
          "selectionId": selectedSelectionID,
          "page": page,
          "pageSize": pageSize
        };
        return teamProvider.get(filter: filter);
      }
    );
    initForm();
  }
  Future initForm() async{
    int currentPage = _paginationController.items.length < 2 && _paginationController.currentPage > 0 ? _paginationController.currentPage - 1 : _paginationController.currentPage;
    await _paginationController.loadPage(currentPage);
    var selectionData = await selectionProvider.get(); 
    setState(() {
      selectionResult = selectionData;
    });
   }
  @override
  Widget build(BuildContext context)
  {
    return MasterScreen("Lista timova", selectedIndex: widget.selectedIndex,
    Column(
      children: [
        _buildSearch(),
        AnimatedBuilder(
          animation: _paginationController,
          builder: (context, _) => _buildResultView(),
          )
      ],
    ));
  }

final TextEditingController _ftsEditingController = TextEditingController();
String? selectedSelectionID;
Widget _buildSearch()
{
  return selectionResult == null ? const SizedBox.shrink() : Padding(
    padding: const EdgeInsets.all(15),
    child: Row(
    children: [
      Expanded(child: TextField(controller: _ftsEditingController,decoration: const InputDecoration(labelText: "Naziv"),)),
      const SizedBox(width: 8,),
      Expanded(
                  child: FormBuilderDropdown(
                    name: "selectionId",
                    decoration: const InputDecoration(
                      labelText: "Selekcija",
                    ),
                    focusColor: Colors.transparent,
                    items: [const DropdownMenuItem(value: "all", child: Text("Sve"),), ...selectionResult?.result.map((item) => 
                    DropdownMenuItem(value: item.id.toString(), child: Text(item.name ?? ""),)).toList() ?? [],],
                    onChanged: (value){
                      setState(() {
                        value == "all" ? selectedSelectionID = null : selectedSelectionID = value.toString();
                      });
                    },
                    )
                  ),
      const SizedBox(width: 8,),            
      ElevatedButton(onPressed: () async{
        await _paginationController.loadPage(0);
      }, child: const Icon(Icons.search)),
      const SizedBox(width: 8,),
      ElevatedButton(onPressed: () async{
       final actionResult = await Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => TeamsDetailsScreen(selectedIndex: widget.selectedIndex,),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
            },
          ));
          if(actionResult == true)
          {
            initForm();
          }
      }, child: const Text("Dodaj"))
    ],
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
              : _paginationController.items.isEmpty ? const Center(child: Text('Nema podataka'),)
              : SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    child: DataTable(
                      columnSpacing: 16.0,
                      horizontalMargin: 8.0,
                      showCheckboxColumn: false,
                      columns: const [
                        DataColumn(
                          label: SizedBox(
                            width: 40,
                            child: Center(
                              child: Text(
                                "Slika",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Naziv",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Selekcija",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
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
                      rows: _paginationController.items
                          .map(
                            (e) => DataRow(
                              onSelectChanged: (_) => _handleRowTap(e),
                              cells: [
                                DataCell(
                                  e.picture != null
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8),
                                          child: SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: imageFromString(e.picture!),
                                          ),
                                        )
                                      : SizedBox(
                                          width: 50,
                                          child: Image.asset('assets/images/team_placeholder.png'),
                                        ),
                                ),
                                DataCell(Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(e.name ?? ""),
                                )),
                                DataCell(Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(e.selection?.name ?? ""),
                                )),
                                DataCell(Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    tooltip: 'Obriši',
                                    onPressed: () async{
                                      await deleteEntity(context: context,
                                      deleteFunction: teamProvider.delete,
                                      entityId: e.id!, 
                                      onDeleted: initForm);
                                    },)
                                )),
                              ],
                            ),
                          )
                          .toList(),
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


  _handleRowTap(Teams selectedTeam) async{
    final actionResult = await Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => TeamsDetailsScreen(team: selectedTeam, selectedIndex: widget.selectedIndex,),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    ),
  );

  if (actionResult == true) {
    initForm();
  }
  }
}

