import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/models/search_result.dart';
import 'package:ezscores_desktop/models/teams.dart';
import 'package:ezscores_desktop/providers/TeamProvider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:ezscores_desktop/screens/teams_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeamsListScreen extends StatefulWidget
{
  const TeamsListScreen({super.key});

  @override
  State<TeamsListScreen> createState() => _TeamsListScreenState();
}

class _TeamsListScreenState extends State<TeamsListScreen> {
  late TeamProvider teamProvider;
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
    super.initState();
    initForm();
  }
  Future initForm() async{
    var data = await teamProvider.get();
    setState(() {
      result = data;
    });
   }
  SearchResult<Teams>? result = null; 
  @override
  Widget build(BuildContext context)
  {
    return MasterScreen("Lista timova", 
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
final TextEditingController _ftsOrganizerController = TextEditingController();
Widget _buildSearch()
{
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Row(
    children: [
      Expanded(child: TextField(controller: _ftsEditingController,decoration: InputDecoration(labelText: "Naziv"),)),
      SizedBox(width: 8,),
      Expanded(child: TextField(controller: _ftsOrganizerController,decoration: InputDecoration(labelText: "Organizator"),)),

      ElevatedButton(onPressed: () async{
        var filter = {
          "name" : _ftsEditingController.text
        };
        var data = await teamProvider.get(filter: filter);
        setState(() {
          result = data;
        });
      }, child: Text("Pretraga")),
       SizedBox(width: 8,),
       ElevatedButton(onPressed: () async{
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => TeamsDetailsScreen()));
      }, child: Text("Dodaj"))
    ],
  )
  );
}
Widget _buildResultView() {
  if(result != null)
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
              label: Expanded(
                child: Text(
                  "Id",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  "Naziv",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
             DataColumn(
              label: Expanded(
                child: Text(
                  "Selekcija",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  "Slika",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
          rows: result?.result.map((e)=>
            DataRow(
              onSelectChanged: (isItemSelected) {
                if(isItemSelected == true)
                {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => TeamsDetailsScreen(team: e,)));
                }
                
              },
              cells: [
              DataCell(Text(e.id.toString())),
              DataCell(Text(e.name ?? "")),
              DataCell(Text(e.selection?.name ?? "")),
              DataCell(e.picture != null ? Container(width: 100, height: 100, child: imageFromString(e.picture!),): Text(""))
            ])
          ).toList().cast<DataRow>() ?? [],
        ),
      ),
    ),
  );
  }
  else
  {
    return const Center(child: CircularProgressIndicator());
  }
}

}

