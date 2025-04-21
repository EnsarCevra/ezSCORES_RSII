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
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      )
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

      ElevatedButton(onPressed: () async{
        var filter = {
          "name" : _ftsEditingController.text,
          "selectionId" : selectedSelectionID
        };
        var data = await teamProvider.get(filter: filter);
        setState(() {
          teamsResult = data;
        });
      }, child: Text("Pretraga")),
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
    return Expanded(
    child: SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: DataTable(
          columnSpacing: 16.0,
          columns: const [
            DataColumn(
                label: Align(
                  alignment: Alignment.center,
                  child: Text(textAlign: TextAlign.center,
                    "Naziv",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
            ),
             DataColumn(
                  label: Center(
                    child: Text(
                      "Selekcija",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
            ),
            DataColumn(
                  label: Center(
                    child: Text(textAlign: TextAlign.center,
                      "Slika",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
            ),
          ],
          rows: teamsResult?.result.map((e)=>
            DataRow(
              cells: [
              DataCell(Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text(e.name ?? ""),),
              ), onTap: () => _handleRowTap(e)),
              DataCell(Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text(e.selection?.name ?? "")),
              ), onTap: () => _handleRowTap(e)),
              DataCell(e.picture != null ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Container(width: 100, height: 100, child: imageFromString(e.picture!),)),
              ): Center(child: Container(child: Image.asset('assets/images/TeamPlaceholder.png', fit: BoxFit.cover,))), onTap: () => _handleRowTap(e))
            ])
          ).toList().cast<DataRow>() ?? [],
        ),
      ),
    ),
  );
  }
  else
  {
    return Expanded(child: Align(alignment: Alignment.center, child: CircularProgressIndicator(),),);
  }
}

  _handleRowTap(Teams e) async{
    final actionResult = await Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => TeamsDetailsScreen(team: e),
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

