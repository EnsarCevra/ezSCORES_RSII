import 'package:ezscores_mobile/helpers/app_loading_widget.dart';
import 'package:ezscores_mobile/helpers/pagination/pagination_controller.dart';
import 'package:ezscores_mobile/models/competitions.dart';
import 'package:ezscores_mobile/models/search_result.dart';
import 'package:ezscores_mobile/models/selections.dart';
import 'package:ezscores_mobile/models/teams.dart';
import 'package:ezscores_mobile/providers/ApplicationsProvider.dart';
import 'package:ezscores_mobile/providers/SelectionProvider.dart';
import 'package:ezscores_mobile/providers/TeamProvider.dart';
import 'package:ezscores_mobile/providers/utils.dart';
import 'package:ezscores_mobile/screens/apply_step_two_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class ApplyStepOneScreen extends StatefulWidget {
  final Competitions competition;
  const ApplyStepOneScreen({super.key, required this.competition});
  @override
  State<ApplyStepOneScreen> createState() => _ApplyStepOneScreenState();
}

class _ApplyStepOneScreenState extends State<ApplyStepOneScreen> {
  int? _selectedSelectionID;
  late TeamProvider teamProvider;
  late SelectionProvider selectionProvider;
  SearchResult<Selections>? selectionResult;
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _searchController = TextEditingController();

  late PaginationController<Teams> _paginationController;
  final ScrollController _scrollController = ScrollController();


  late ApplicationProvider applicationProvider;
  Teams? selectedTeam;

  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
    teamProvider = context.read<TeamProvider>();
    selectionProvider = context.read<SelectionProvider>();
    applicationProvider = context.read<ApplicationProvider>();
    _loadSelections();
    _paginationController = PaginationController<Teams>(
      fetchPage: (page, pageSize) {
        var filter = {
          "name": _searchController.text,
          "selectionId" : _selectedSelectionID,
          "includeTeamsThatAlreadyAppliedForCompetition" : false,
          "competitionId" : widget.competition.id,
          "onlyUsersTeams" : true,
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
        title: const Text("Prijava na takmičenje",
        style: TextStyle(fontSize: 15),),
        actions: const [
          LogoutButton()
        ],
      ),
      body: Padding(
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
      floatingActionButton: selectedTeam == null ? const SizedBox.shrink()
      : FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
        try {
          var request = {
            "teamId": selectedTeam!.id,
            "competitionId": widget.competition.id
          };
          await applicationProvider.validateTeam(request);
          Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => ApplyStepTwoScreen(competition: widget.competition, selectedTeam: selectedTeam!,),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                );
        } on Exception catch (e) {
          showMobileErrorNotification(context, e.toString());
        }
        },
        child: const Icon(Icons.next_plan, size: 28, color: Colors.white,),
      ),
    );
  }
  _buildSearch(){
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _searchController,
          style: textTheme.bodySmall,
          decoration: InputDecoration(
            labelText: "Pretraga timova",
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
                        _paginationController.loadPage();
                      });
                    },
                  )
                : null,
          ),
          onChanged: (value) async{
            _searchController.text = value;
            await _paginationController.loadPage();
            var isSelectedTeamInSearchResult = _paginationController.items.any((element) => element.id == selectedTeam?.id);
            if(!isSelectedTeamInSearchResult)
            {
              setState(() {
                selectedTeam = null;
              });
            }
          },
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(Icons.emoji_events),
            const SizedBox(width: 20,),
            Text(
              '${widget.competition.name!} - ${widget.competition.selection?.name}'
            ),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.people),
            const SizedBox(width: 20,),
            Text(
              '${selectedTeam?.name != null ? selectedTeam?.name! : ''}'
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
    final bool isSelected = selectedTeam?.id == team.id;

    return InkWell(
      onTap: () {
        setState(() {
          selectedTeam = team;
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        color: isSelected ? Colors.blue.shade100 : Colors.white,
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
