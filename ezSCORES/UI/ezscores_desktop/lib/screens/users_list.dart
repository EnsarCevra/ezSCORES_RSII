import 'package:ezscores_desktop/helpers/pagination/pagination_controller.dart';
import 'package:ezscores_desktop/helpers/pagination/pagination_controlls.dart';
import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/models/roles.dart';
import 'package:ezscores_desktop/models/search_result.dart';
import 'package:ezscores_desktop/models/users.dart';
import 'package:ezscores_desktop/providers/RolesProvider.dart';
import 'package:ezscores_desktop/providers/UserProvider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:ezscores_desktop/screens/profile_screen.dart';
import 'package:ezscores_desktop/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class UsersListScreen extends StatefulWidget {
  final int selectedIndex;
  const UsersListScreen({super.key, required this.selectedIndex});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  late UserProvider userProvider;
  late RolesProvider roleProvider;
  late PaginationController<Users> _paginationController;
  SearchResult<Roles>? rolesResult;
  String? selectedRoleID;
  final TextEditingController _gteFirstLastNameEditingController = TextEditingController();
  final TextEditingController _ftsUsernameEditingController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userProvider = context.read<UserProvider>();
    roleProvider = context.read<RolesProvider>();
  }

  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();
    roleProvider = context.read<RolesProvider>();
    _paginationController = PaginationController<Users>(
      fetchPage: (page, pageSize){
        final filter = <String, dynamic>{
        if (_gteFirstLastNameEditingController.text.isNotEmpty)
          "firstNameGTE": _gteFirstLastNameEditingController.text,
        if (_ftsUsernameEditingController.text.isNotEmpty)
          "userName": _ftsUsernameEditingController.text,
        if (selectedRoleID != null) "roleId": selectedRoleID,
        "isRolesIncluded": true,
        "page": page,
        "pageSize": pageSize,
      };
        return userProvider.get(filter: filter);
      }
    );
    initForm();
  }

  Future initForm() async {
    int currentPage = _paginationController.items.length < 2 && _paginationController.currentPage > 0 ? _paginationController.currentPage - 1 : _paginationController.currentPage;
    await _paginationController.loadPage(currentPage);
    var roleData = await roleProvider.get();
    setState(() {
      rolesResult = roleData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Lista korisnika",
      selectedIndex: widget.selectedIndex,
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
              controller: _gteFirstLastNameEditingController,
              decoration: const InputDecoration(labelText: "Ime ili prezime"),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _ftsUsernameEditingController,
              decoration: const InputDecoration(labelText: "Korisničko ime"),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 150,
            child: FormBuilderDropdown(
              name: "roleId",
              decoration: const InputDecoration(
                labelText: "Uloga",
              ),
              focusColor: Colors.transparent,
              items: [const DropdownMenuItem(value: "all", child: Text("Sve"),), ...rolesResult?.result.map((item) => 
              DropdownMenuItem(value: item.id.toString(), child: Text(item.name ?? ""),)).toList() ?? [],],
              onChanged: (value){
                setState(() {
                  value == "all" ? selectedRoleID = null : selectedRoleID = value.toString();
                });
              },
              )
            ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () async {
              await _paginationController.loadPage(0);
              setState(() {
              });
            },
            child: const Icon(Icons.search),
          ),
          const SizedBox(width: 8),
          ElevatedButton(onPressed: () async{
            final actionResult = await Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => RegisterScreen(selectedIndex: widget.selectedIndex,),
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
    );
  }

Widget _buildResultView() {
  return Expanded(
    child: Column(
      children: [
        /// Main content
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
                                    "Korisničko ime",
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
                                    "Uloga",
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
                          rows: _paginationController.items.map((e) {
                            return DataRow(
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
                                              : const Icon(Icons.no_accounts),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(Center(child: Text(e.firstName ?? ""))),
                                DataCell(Center(child: Text(e.lastName ?? ""))),
                                DataCell(Center(child: Text(e.userName ?? ""))),
                                DataCell(Center(child: Text(e.role?.name ?? ""))),
                                DataCell(Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    tooltip: 'Obriši',
                                    onPressed: () async{
                                      await deleteEntity(context: context,
                                      deleteFunction: userProvider.delete,
                                      entityId: e.id!, 
                                      onDeleted: initForm);
                                    },)
                                )),
                              ],
                            );
                          }).toList(),
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


  _handleRowTap(Users selectedUser) async {
    final actionResult = await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ProfileScreen(user: selectedUser, selectedIndex: widget.selectedIndex,),
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
