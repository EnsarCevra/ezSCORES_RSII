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
  SearchResult<Selections>? selectionResult = null;
  SearchResult<Teams>? teamsResult = null; 
   @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();
    teamProvider = context.read<TeamProvider>();
  }
  @override
  void initState() {
    // TODO: implement initState
    teamProvider = context.read<TeamProvider>();
    selectionProvider = context.read<SelectionProvider>();
    super.initState();
    initForm();
  }
  Future initForm() async{
    var teamData = await teamProvider.get();
    var selectionData = await selectionProvider.get(); 
    setState(() {
      teamsResult = teamData;
      selectionResult = selectionData;
    });
   }
  @override
  Widget build(BuildContext context)
  {
    return MasterScreen("Lista timova", selectedIndex: widget.selectedIndex,
    Container(
      child: Column(
        children: [
          _buildSearch(),
          _buildResultView()
        ],
      ),
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
      Expanded(child: TextField(controller: _ftsEditingController,decoration: InputDecoration(labelText: "Naziv"),)),
      SizedBox(width: 8,),
      Expanded(
                  child: FormBuilderDropdown(
                    name: "selectionId",
                    decoration: InputDecoration(
                      labelText: "Selekcija",
                    ),
                    focusColor: Colors.transparent,
                    items: [DropdownMenuItem(value: "all", child: Text("Sve"),), ...selectionResult?.result.map((item) => 
                    DropdownMenuItem(value: item.id.toString(), child: Text(item.name ?? ""),)).toList() ?? [],],
                    onChanged: (value){
                      setState(() {
                        value == "all" ? selectedSelectionID = null : selectedSelectionID = value.toString();
                      });
                    },
                    )
                  ),
      SizedBox(width: 8,),            
      ElevatedButton(onPressed: () async{
        var filter = {
          "name" : _ftsEditingController.text,
          "selectionId" : selectedSelectionID
        };
        var data = await teamProvider.get(filter: filter);
        setState(() {
          teamsResult = data;
        });
      }, child: Icon(Icons.search)),
      SizedBox(width: 8,),
      ElevatedButton(onPressed: () async{
       final actionResult = await Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => TeamsDetailsScreen(),
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
      }, child: Text("Dodaj"))
    ],
  )
  );
}
Widget _buildResultView() {
  if(teamsResult != null)
  {
    return teamsResult!.count != 0 ? Expanded(
    child: SingleChildScrollView(
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
                        child: Text(textAlign: TextAlign.center,
                          "Slika",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
            ),
            DataColumn(
                  label: Text(textAlign: TextAlign.center,
                      "Naziv",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
            ),
             DataColumn(
                    label: Text(
                        "Selekcija",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
            ),
          ],
          rows: teamsResult?.result.map((e)=>
            DataRow(
              onSelectChanged: (_) => _handleRowTap(e),
              cells: [
                DataCell(e.picture != null ? Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: SizedBox(width: 50, height: 50, child: imageFromString(e.picture!),),
                )
              : SizedBox(width: 50, child: Image.asset('assets/images/team_placeholder.png',)),),
              DataCell(Padding(
                padding: const EdgeInsets.all(8.0),
                child:Text(e.name ?? ""),
              ),),
              DataCell(Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(e.selection?.name ?? ""),
              ),),
            ])
          ).toList().cast<DataRow>() ?? [],
        ),
      ),
    ),
  ) : Expanded(child: Align(alignment: Alignment.center, child: Text('Nema podataka'),),);;
  }
  else
  {
    return Expanded(child: Align(alignment: Alignment.center, child: CircularProgressIndicator(),),);
  }
}

  _handleRowTap(Teams selectedTeam) async{
    final actionResult = await Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => TeamsDetailsScreen(team: selectedTeam),
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

