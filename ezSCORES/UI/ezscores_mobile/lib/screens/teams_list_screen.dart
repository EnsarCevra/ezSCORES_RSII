import 'package:ezscores_mobile/helpers/app_loading_widget.dart';
import 'package:ezscores_mobile/helpers/not_logged_in_widget.dart';
import 'package:ezscores_mobile/helpers/pagination/pagination_controller.dart';
import 'package:ezscores_mobile/main.dart';
import 'package:ezscores_mobile/models/search_result.dart';
import 'package:ezscores_mobile/models/selections.dart';
import 'package:ezscores_mobile/models/teams.dart';
import 'package:ezscores_mobile/providers/SelectionProvider.dart';
import 'package:ezscores_mobile/providers/TeamProvider.dart';
import 'package:ezscores_mobile/providers/auth_provider.dart';
import 'package:ezscores_mobile/providers/utils.dart';
import 'package:ezscores_mobile/screens/login_screen.dart';
import 'package:ezscores_mobile/screens/teams_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class TeamsListScreen extends StatefulWidget {
  @override
  State<TeamsListScreen> createState() => _TeamsListScreenState();
}

class _TeamsListScreenState extends State<TeamsListScreen> {
  int? _selectedSelectionID;
  late TeamProvider teamProvider;
  late SelectionProvider selectionProvider;
  SearchResult<Selections>? selectionResult;
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _searchController = TextEditingController();

  late PaginationController<Teams> _paginationController;
  final ScrollController _scrollController = ScrollController();

  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
    teamProvider = context.read<TeamProvider>();
    selectionProvider = context.read<SelectionProvider>();
    _loadSelections();
    _paginationController = PaginationController<Teams>(
      fetchPage: (page, pageSize) {
        var filter = {
          "name": _searchController.text,
          "selectionId" : _selectedSelectionID,
          //"onlyUsersTeams" : true, //uncomment this when finished
          "page": page,
          "pageSize": pageSize,
        };
        return teamProvider.get(filter: filter);
      },
    );
    _paginationController.addListener(() {
      setState(() {});
    });

    _paginationController.loadPage();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
        _paginationController.loadMore();
      }
    });
  }
  _loadSelections() async{
     var selectionData = await selectionProvider.get();
     selectionResult = selectionData;
  }
  @override
  void dispose() {
    _searchController.dispose();
    _paginationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Moje ekipe",
        style: TextStyle(fontSize: 15),),
        actions: const [
          LogoutButton()
        ],
      ),
      body: !AuthProvider.isLoggedIn() ? NotLoggedInWidget(onLogin: (){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()));
      })
      : Padding(
        padding: const EdgeInsets.all(12.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              _buildSearch(),
              const SizedBox(height: 12),
              Expanded(child: _buildTeamsResultView())
            ]
          ),
        ),
      ),
      floatingActionButton: !AuthProvider.isLoggedIn() ? const SizedBox.shrink()
      : FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          final created = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TeamsDetailsScreen(),
            ),
          );

          if (created == true) {
            _paginationController.loadPage();
          }
        },
        child: const Icon(Icons.add, size: 28, color: Colors.white,),
      ),
    );
  }
  _buildSearch(){
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        TextField(
          controller: _searchController,
          style: textTheme.bodySmall,
          decoration: InputDecoration(
            labelText: "Naziv tima",
            labelStyle: textTheme.bodySmall,
            prefixIcon: const Icon(Icons.search, size: 18),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                      });
                    },
                  )
                : null,
          ),
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            Expanded(
              child: FormBuilderDropdown<int>(
                name: "selectionId",
                decoration: InputDecoration(
                  labelText: "Selekcija",
                  labelStyle: textTheme.bodySmall,
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  suffixIcon: _selectedSelectionID != null
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _selectedSelectionID = null;
                              _formKey.currentState
                                  ?.fields['selectionId']
                                  ?.reset();
                            });
                          },
                        )
                      : null,
                ),
                items: [
                  ...?selectionResult?.result.map(
                    (item) => DropdownMenuItem(
                      value: item.id,
                      child: Text(item.name ?? "", style: textTheme.bodySmall,),
                    ),
                  )
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedSelectionID = value;
                  });
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        /// Filter button
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton.icon(
              onPressed: _paginationController.loadPage,
              icon: const Icon(Icons.filter_alt, size: 18),
              label: const Text(
                "Filtriraj",
                style: TextStyle(fontSize: 13),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ],
        ),
      ],
    );

  }
  _buildTeamsResultView() {
    return AnimatedBuilder(
      animation: _paginationController,
      builder: (context, _) {
        if (_paginationController.isLoading && _paginationController.items.isEmpty) {
          return const AppLoading();
        }

        if (_paginationController.items.isEmpty) {
          return const Center(child: Text("Nema podataka"));
        }

        return ListView.builder(
          controller: _scrollController,
          itemCount: _paginationController.items.length + (_paginationController.hasNext ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < _paginationController.items.length) {
              final team = _paginationController.items[index];
              return _buildTeamCard(context, team);
            } else {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: AppLoading(),
              );
            }
          },
        );
      },
    );
  }

  Widget _buildTeamCard(BuildContext context, Teams team) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () async {
        final shouldReload = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => TeamsDetailsScreen(team: team,)
                )
              )
            );
        if(shouldReload != null && shouldReload == true)
        {
          _paginationController.loadPage();
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey[300],
                  child: team.picture == null || team.picture!.isEmpty
                      ? const Icon(Icons.groups, size: 30, color: Colors.grey)
                      : imageFromString(team.picture!),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      team.name ?? "Nepoznat tim",
                      style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      team.selection?.name ?? "",
                      style: textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
