import 'package:ezscores_desktop/helpers/pagination/pagination_controller.dart';
import 'package:ezscores_desktop/helpers/pagination/pagination_controlls.dart';
import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/models/players.dart';
import 'package:ezscores_desktop/models/search_result.dart';
import 'package:ezscores_desktop/providers/PlayersProvider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:ezscores_desktop/screens/players_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PlayersListScreen extends StatefulWidget
{
  final int selectedIndex;
  const PlayersListScreen({super.key, required this.selectedIndex});
  
  @override
  State<StatefulWidget> createState() => _PlayerListScreen();
}
class _PlayerListScreen extends State<PlayersListScreen>
{
  late PlayerProvider playerProvider;
  late PaginationController<Players> _paginationController;
  DateTime? _selectedDate;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    playerProvider = context.read<PlayerProvider>();
    _paginationController = PaginationController<Players>(
      fetchPage: (page, pageSize){
        var filter = {
          "firstNameLastNameGTE" : _gteFirstLastNameEditingController.text,
          "birthDate" : _selectedDate,
          "year" : _birthYearEditingController.text,
          "page": page,
          "pageSize": pageSize
        };
        return playerProvider.get(filter: filter);
      }
    );
    initForm();
  } 

  Future initForm() async{
    int currentPage = _paginationController.items.length < 2 && _paginationController.currentPage > 0 ? _paginationController.currentPage - 1 : _paginationController.currentPage;
    await _paginationController.loadPage(currentPage);
    setState(() {
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
          AnimatedBuilder(
            animation: _paginationController,
            builder: (context, _) => _buildResultView(),
          )
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
    child: Form(
      key: _formKey,
      child: Row(
      children: [
        Expanded(child: TextField(controller: _gteFirstLastNameEditingController, decoration: InputDecoration(labelText: "Ime/prezime"),)),
        SizedBox(width: 8,),
        SizedBox(
          width: 150,
          child: TextFormField(
            controller: _birthYearEditingController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Godina rođenja',
              hintText: 'npr. 2002',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.integer(errorText: 'Unesite ispravnu godinu'),
              FormBuilderValidators.min(1950, errorText: 'Godina mora biti nakon 1950.'),
              FormBuilderValidators.max(DateTime.now().year, errorText: 'Godina ne može biti veća od trenutne (${DateTime.now().year})'),
            ]),
          ),
        ),
        const SizedBox(width: 8,),
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
                icon: const Icon(Icons.clear)
                ) : null,
            ),
            onTap: () => _pickDate(context),
          ),
        ),
        const SizedBox(width: 8,),
        ElevatedButton(onPressed: () async{
          await _paginationController.loadPage(0);
          setState(() {
          });
        }, child: const Icon(Icons.search)),
         const SizedBox(width: 8,),
         ElevatedButton(onPressed: () async{
            final actionResult = await Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => PlayersDetailsScreen(selectedIndex: widget.selectedIndex,),
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
                            DataColumn(
                              label: Flexible(
                                child: Center(
                                  child: Text(
                                    "Datum rođenja",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
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
                              DataCell(
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text(formatDateOnly(e.birthDate))),
                                ),
                              ),
                              DataCell(Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    tooltip: 'Obriši',
                                    onPressed: () async{
                                      await deleteEntity(context: context,
                                      deleteFunction: playerProvider.delete,
                                      entityId: e.id!, 
                                      onDeleted: initForm);
                                    },)
                                )),
                            ],
                          )).toList(),
                        ),
                      ),
                    ),
        ),

        /// Pagination controls pinned at bottom
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: PaginationControls(controller: _paginationController),
        ),
      ],
    ),
  );
}

  
  _handleRowTap(Players selectedPlayer) async{
    final actionResult = await Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PlayersDetailsScreen(player: selectedPlayer, selectedIndex: widget.selectedIndex,),
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