import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/models/search_result.dart';
import 'package:ezscores_desktop/models/users.dart';
import 'package:ezscores_desktop/providers/UserProvider.dart';
import 'package:ezscores_desktop/providers/utils.dart';
import 'package:ezscores_desktop/screens/users_details_screen.dart';
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
  SearchResult<Users>? usersResult = null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userProvider = context.read<UserProvider>();
  }

  @override
  void initState() {
    userProvider = context.read<UserProvider>();
    super.initState();
    initForm();
  }

  Future initForm() async {
    var filter = 
    {
      "isRolesIncluded": true
    };
    var userData = await userProvider.get(filter: filter);
    setState(() {
      usersResult = userData;
    });
  }

  final TextEditingController _gteFirstLastNameEditingController = TextEditingController();
  final TextEditingController _ftsUsernameEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Lista korisnika",
      selectedIndex: widget.selectedIndex,
      Container(
        child: Column(
          children: [
            _buildSearch(),
            _buildResultView()
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
              decoration: InputDecoration(labelText: "Ime ili prezime"),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _ftsUsernameEditingController,
              decoration: InputDecoration(labelText: "Korisničko ime"),
            ),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () async {
              var filter = {
                "firstNameGTE" : _gteFirstLastNameEditingController.text,
                "userName" : _ftsUsernameEditingController.text,
                "isRolesIncluded": true,
              };
              var data = await userProvider.get(filter: filter);
              setState(() {
                usersResult = data;
              });
            },
            child: Icon(Icons.search),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () async {
              final actionResult = await Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => UsersDetailsScreen(),
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
    );
  }

  Widget _buildResultView() {
    if (usersResult != null) {
      return usersResult!.count != 0
          ? Expanded(
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
                    ],
                    rows: usersResult?.result.map((e) =>
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
                              child: Center(child: Text(e.userName ?? "")),
                            ),
                          ),
                          DataCell(
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(child: Text(e.role?.name ?? "")),
                            ),
                          ),
                        ],
                      )
                    ).toList().cast<DataRow>() ?? [],
                  ),
                ),
              ),
            )
          : Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text('Nema podataka'),
              ),
            );
    } else {
      return Expanded(
        child: Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  _handleRowTap(Users selectedUser) async {
    final actionResult = await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => UsersDetailsScreen(user: selectedUser),
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
