import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/models/players.dart';
import 'package:ezscores_desktop/models/search_result.dart';
import 'package:ezscores_desktop/providers/PlayersProvider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:ezscores_desktop/screens/players_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PlayersListScreen extends StatefulWidget
{
  final int selectedIndex;
  const PlayersListScreen({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context)
  {
    // return MasterScreen("Lista korisnika", Column(
    //   children: [
    //     Text("Lista korisnika placeholder"),
    //     SizedBox(height: 10,),
    //     ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text("Back"))
    //   ],
    // ));
    return MasterScreen("Lista igrača", Placeholder(), selectedIndex: 3,);
  }
  
  @override
  State<StatefulWidget> createState() => _PlayerListScreen();
}
class _PlayerListScreen extends State<PlayersListScreen>
{
  late PlayerProvider playerProvider;
  DateTime? _selectedDate;
  SearchResult<Players>? playerResult = null; 
  @override
  void initState() {
    playerProvider = context.read<PlayerProvider>();
    super.initState();
    initForm();
  } 

  Future initForm() async{
    var playerData = await playerProvider.get();
    setState(() {
      playerResult = playerData;
      print(playerResult);
    });
   }


   @override
  Widget build(BuildContext context)
  {
    return MasterScreen("Lista igrača", selectedIndex: widget.selectedIndex,
    Container(
      child: Column(
        children: [
          _buildSearch(),
          _buildResultView()
        ],
      ),
    ));
  }
  final TextEditingController _gteFirstLastNameEditingController = TextEditingController();
  final TextEditingController _birthYearEditingController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  _buildSearch() {
    return Padding(
    padding: const EdgeInsets.all(15),
    child: Row(
    children: [
      Expanded(child: TextField(controller: _gteFirstLastNameEditingController, decoration: InputDecoration(labelText: "Ime/prezime"),)),
      SizedBox(width: 8,),
      SizedBox(
        width: 150,
        child: TextField(
          controller: _birthYearEditingController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Godina rođenja',
            hintText: 'npr. 2002',
          ),
        ),
      ),
      SizedBox(width: 8,),
      SizedBox(
        width: 200,
        child: TextField(
          controller: _dateController,
          readOnly: true,
          decoration: InputDecoration(
            labelText: 'Datum rođenja',
            suffixIcon: _selectedDate != null ? IconButton(
              onPressed: (){
                setState(() {
                  _selectedDate = null;
                   _dateController.clear();
                });
              }, 
              icon: Icon(Icons.clear)
              ) : null,
          ),
          onTap: () => _pickDate(context),
        ),
      ),
      SizedBox(width: 8,),
      ElevatedButton(onPressed: () async{
        var filter = {
          "firstNameLastNameGTE" : _gteFirstLastNameEditingController.text,
          "birthDate" : _selectedDate,
          "year" : _birthYearEditingController.text
        };
        var data = await playerProvider.get(filter: filter);
        setState(() {
          playerResult = data;
        });
      }, child: Icon(Icons.search)),
       SizedBox(width: 8,),
       ElevatedButton(onPressed: () async{
       final actionResult = await Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => PlayersDetailsScreen(),
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
  
  _buildResultView() {
    if(playerResult != null)
  {
    return playerResult!.count != 0 ? Expanded(
    child: SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: DataTable(
          columnSpacing: 16.0,
          showCheckboxColumn: false,
          columns: const [
            DataColumn(
                label: Center(
                  child: Text(textAlign: TextAlign.center,
                    "Slika",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
            ),
            DataColumn(
                label: Align(
                  alignment: Alignment.center,
                  child: Text(textAlign: TextAlign.center,
                    "Ime",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
            ),
             DataColumn(
                  label: Center(
                    child: Text(
                      "Prezime",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
            ),
            DataColumn(
                  label: Center(
                    child: Text(textAlign: TextAlign.center,
                      "Datum rođenja",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
            ),
          ],
          rows: playerResult?.result.map((e)=>
            DataRow(
              onSelectChanged: (_) => _handleRowTap(e),
              cells: [
                DataCell(
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: e.picture != null
                                  ? imageFromString(e.picture!)
                                  : Image.asset('assets/images/default_profile_image.jpg', fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                    ),

              DataCell(Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text(e.firstName ?? ""),),
              ),),
              DataCell(Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text(e.lastName ?? "")),
              ),),
              DataCell(Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text(formatDateOnly(e.birthDate))),
              ),),
            ])
          ).toList().cast<DataRow>() ?? [],
        ),
      ),
    ),
  ) : Expanded(child: Align(alignment: Alignment.center, child: Text('Nema podataka'),),);
  }
  else
  {
    return Expanded(child: Align(alignment: Alignment.center, child: CircularProgressIndicator(),),);
  }
  }
  
  _handleRowTap(Players selectedPlayer) async{
    final actionResult = await Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PlayersDetailsScreen(player: selectedPlayer),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    ),
  );

  if (actionResult == true) {
    initForm();
  }
  }
  
  Future<void> _pickDate(BuildContext context) async{
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
       firstDate: DateTime(DateTime.now().year - 70), 
       lastDate: DateTime.now()
      );
    if(picked != null)
    {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd.MM.yyyy').format(picked);
      });
    }
  }
}