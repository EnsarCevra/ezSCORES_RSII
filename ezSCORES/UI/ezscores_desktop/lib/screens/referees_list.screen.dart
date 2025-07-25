import 'package:ezscores_desktop/helpers/pagination/pagination_controller.dart';
import 'package:ezscores_desktop/helpers/pagination/pagination_controlls.dart';
import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/models/referees.dart';
import 'package:ezscores_desktop/models/search_result.dart';
import 'package:ezscores_desktop/providers/RefereesProvider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
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
  late PaginationController<Referees> _paginationController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    refereeProvider = context.read<RefereeProvider>();
    _paginationController = PaginationController<Referees>(
      fetchPage: (page, pageSize){
        var filter = {
          "firstNameLastNameGTE" : _gteFirstLastNameEditingController.text,
          "page": page,
          "pageSize": pageSize
        };
        return refereeProvider.get(filter: filter);
      }
    );
    initForm();
  } 

  Future initForm() async{
    await _paginationController.loadPage();
    setState(() {
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
          AnimatedBuilder(
          animation: _paginationController,
          builder: (context, _) => _buildResultView(),
          )
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
          await _paginationController.loadPage(0);
          setState(() {
          });
        }, child: const Icon(Icons.search)),
        const SizedBox(width: 8,),
         ElevatedButton(onPressed: () async{
            final actionResult = await Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => RefereesDetailsScreen(selectedIndex: widget.selectedIndex),
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
                          columns: const [
                            DataColumn(
                              label: Flexible(
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
                              label: Flexible(
                                child: Center(
                                  child: Text(
                                    "Ime",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
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
                          rows: _paginationController.items.map((e) => DataRow(
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
                              DataCell(
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text(e.firstName ?? "")),
                                ),
                              ),
                              DataCell(
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text(e.lastName ?? "")),
                                ),
                              ),
                            ],
                          )).toList(),
                        ),
                      ),
                    ),
        ),

        /// Pagination controls always pinned at the bottom
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: PaginationControls(controller: _paginationController),
        ),
      ],
    ),
  );
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