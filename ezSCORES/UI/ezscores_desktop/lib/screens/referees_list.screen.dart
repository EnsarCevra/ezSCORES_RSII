import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/models/referees.dart';
import 'package:ezscores_desktop/models/search_result.dart';
import 'package:ezscores_desktop/providers/RefereesProvider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:ezscores_desktop/screens/players_details_screen.dart';
import 'package:ezscores_desktop/screens/referees_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RefereesListScreen extends StatefulWidget
{
  final int selectedIndex;
  const RefereesListScreen({super.key, required this.selectedIndex});
  
  @override
  State<RefereesListScreen> createState() => _RefereesListScreenState();
}
class _RefereesListScreenState extends State<RefereesListScreen>
{
  late RefereeProvider refereeProvider;
  SearchResult<Referees>? refereeResult; 
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    refereeProvider = context.read<RefereeProvider>();
    super.initState();
    initForm();
  } 

  Future initForm() async{
    var refereeData = await refereeProvider.get();
    setState(() {
      refereeResult = refereeData;
    });
   }


   @override
  Widget build(BuildContext context)
  {
    return MasterScreen("Lista sudija", selectedIndex: widget.selectedIndex,
    Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildSearch(),
          _buildResultView()
        ],
      ),
    ));
  }
  final TextEditingController _gteFirstLastNameEditingController = TextEditingController();
  _buildSearch() {
    return Padding(
    padding: const EdgeInsets.all(15),
    child: Form(
      key: _formKey,
      child: Row(
      children: [
        Expanded(child: TextField(controller: _gteFirstLastNameEditingController, decoration: const InputDecoration(labelText: "Ime/prezime"),)),
        const SizedBox(width: 8,),
        ElevatedButton(onPressed: () async{
          var filter = {
            "firstNameLastNameGTE" : _gteFirstLastNameEditingController.text,
          };
          var data = await refereeProvider.get(filter: filter);
          setState(() {
            refereeResult = data;
          });
        }, child: const Icon(Icons.search)),
        const SizedBox(width: 8,),
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
            }, child: const Text("Dodaj"))
          ],
        ),
    )
    );
  }
  
  _buildResultView() {
    if(refereeResult != null)
  {
    return refereeResult!.count != 0 ? Expanded(
    child: SingleChildScrollView(
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
                    child: Text(textAlign: TextAlign.center,
                      "Slika",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ),
            DataColumn(
                label: Flexible(
                  child: Center(
                    child: Text(textAlign: TextAlign.center,
                      "Ime",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ),
             DataColumn(
                  label: Flexible(
                    child: Center(
                      child: Text(
                        "Prezime",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
            ),
          ],
          rows: refereeResult?.result.map((e)=>
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
                                  : const Icon(Icons.account_circle, size: 30),
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
            ])
          ).toList().cast<DataRow>() ?? [],
        ),
      ),
    ),
  ) : const Expanded(child: Align(alignment: Alignment.center, child: Text('Nema podataka'),),);
  }
  else
  {
    return const Expanded(child: Align(alignment: Alignment.center, child: CircularProgressIndicator(),),);
  }
  }
  
  _handleRowTap(Referees selectedReferee) async{
    final actionResult = await Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => RefereesDetailsScreen(selectedIndex: widget.selectedIndex, referee: selectedReferee),
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