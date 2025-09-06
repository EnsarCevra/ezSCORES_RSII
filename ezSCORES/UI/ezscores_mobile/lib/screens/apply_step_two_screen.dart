import 'package:ezscores_mobile/helpers/app_loading_widget.dart';
import 'package:ezscores_mobile/helpers/pagination/pagination_controller.dart';
import 'package:ezscores_mobile/models/competitions.dart';
import 'package:ezscores_mobile/models/players.dart';
import 'package:ezscores_mobile/models/teams.dart';
import 'package:ezscores_mobile/providers/ApplicationsProvider.dart';
import 'package:ezscores_mobile/providers/PlayersProvider.dart';
import 'package:ezscores_mobile/providers/base_provider.dart';
import 'package:ezscores_mobile/providers/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class ApplyStepTwoScreen extends StatefulWidget {
  final Competitions competition;
  final Teams selectedTeam;
  const ApplyStepTwoScreen({super.key, required this.competition, required this.selectedTeam});
  @override
  State<ApplyStepTwoScreen> createState() => _ApplyStepTwoScreenState();
}

class _ApplyStepTwoScreenState extends State<ApplyStepTwoScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _searchController = TextEditingController();

  late PaginationController<Players> _paginationController;
  final ScrollController _scrollController = ScrollController();

  late PlayerProvider playerProvider;
  late ApplicationProvider applicationProvider;

  final Set<Players> selectedPlayers = {};
  final Set<int> conflictPlayerIds = {};

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
    applicationProvider = context.read<ApplicationProvider>();
    playerProvider = context.read<PlayerProvider>();
    _paginationController = PaginationController<Players>(
      fetchPage: (page, pageSize) {
        var filter = {
          "firstNameLastNameGTE": _searchController.text,
          "page": page,
          "pageSize": pageSize,
        };
        return playerProvider.get(filter: filter);
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              _buildSearch(),
              const SizedBox(height: 12),
              Expanded(child: _buildPlayersResultView())
            ]
          ),
        ),
      ),
      floatingActionButton: selectedPlayers.length < 5 ? const SizedBox.shrink()
      : FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
        try {
          final List<int> selectedPlayerIds = selectedPlayers
          .where((p) => p.id != null)
          .map((p) => p.id!)
          .toList();
          var request = {
            "competitionId": widget.competition.id,
            "playerIds": selectedPlayerIds
          };
          await applicationProvider.validatePlayers(request);
          // Navigator.of(context).push(
          //         PageRouteBuilder(
          //           pageBuilder: (context, animation, secondaryAnimation) => ApplyStepTwoScreen(competition: widget.competition, selectedTeam: selectedTeam!,),
          //           transitionsBuilder: (context, animation, secondaryAnimation, child) {
          //             return FadeTransition(opacity: animation, child: child);
          //           },
          //         ),
          //       );
        } on UserException catch (e) {
          final parts = e.exMessage.split(':');
          String userMessage = parts.first.trim();
          final regex = RegExp(r'\d+');
          final ids = regex.allMatches(e.exMessage).map((m) => int.parse(m.group(0)!));
          setState(() {
            conflictPlayerIds
              ..clear()
              ..addAll(ids);
          });
          showMobileErrorNotification(context, userMessage);
        }
        },
        child: const Icon(Icons.next_plan, size: 28, color: Colors.white,),
      ),
    );
  }
  
  _buildSearch() {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _searchController,
          style: textTheme.bodySmall,
          decoration: InputDecoration(
            labelText: "Traži igrače",
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
                        _loadPlayers();
                      });
                    },
                  )
                : null,
          ),
          onChanged: (value) async{
            _searchController.text = value;
            _loadPlayers();
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
              widget.selectedTeam.name!
            ),
          ],
        ),
        
        const SizedBox(height: 10,),
        const Text('Trenutni sastav (klikni da uklonis)'),
        _buildSelectedPlayersView()
      ],
    );
  }
  
  Widget _buildPlayersResultView() {
  return AnimatedBuilder(
    animation: _paginationController,
    builder: (context, _) {
      if (_paginationController.isLoading && _paginationController.items.isEmpty) {
        return const AppLoading();
      }

      if (_paginationController.items.isEmpty) {
        return const Center(child: Text("Nema podataka"));
      }

      return GridView.builder(
        controller: _scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.65,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: _paginationController.items.length + (_paginationController.hasNext ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < _paginationController.items.length) {
            final player = _paginationController.items[index];
            return _buildPlayerCard(context, player);
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

Widget _buildPlayerCard(BuildContext context, Players player) {
  final bool isSelected = selectedPlayers.contains(player);

  return InkWell(
    onTap: () {
      setState(() {
        selectedPlayers.add(player);
        _paginationController.items.remove(player);
      });
    },
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      color: isSelected ? Colors.blue.shade100 : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Container(
                width: 50,
                height: 50,
                color: Colors.grey[300],
                child: player.picture == null || player.picture!.isEmpty
                    ? const Icon(Icons.person, size: 30, color: Colors.grey)
                    : imageFromString(player.picture!),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "${player.firstName ?? ''} ${player.lastName ?? ''}",
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              player.birthDate != null
                  ? formatDateOnly(player.birthDate!)
                  : "Nepoznat datum",
              style: const TextStyle(fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}

  Widget _buildSelectedPlayersView() {
  if (selectedPlayers.isEmpty) {
    return const Center(child: Text('Nema igrača u sastavu', style: TextStyle(fontSize: 12),));
  }
  final playersList = selectedPlayers.toList().reversed.toList();

  return SizedBox(
    height: 120,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: playersList.length,
      separatorBuilder: (_, __) => const SizedBox(width: 8),
      itemBuilder: (context, index) {
        final player = playersList.elementAt(index);
        return _buildMiniPlayerCard(player);
      },
    ),
  );
}

Widget _buildMiniPlayerCard(Players player) {
  final bool isConflict = conflictPlayerIds.contains(player.id);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation,
          child: child,
        ),
      ),
      child: InkWell(
        onTap: () async{
          selectedPlayers.remove(player);
          _loadPlayers();
          setState(() {
          });
        },
        child: Card(
          key: ValueKey(player.id),
          color: isConflict ? Colors.red.shade200 : Colors.green.shade200,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: SizedBox(
            width: 80,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.grey[300],
                      child: player.picture == null || player.picture!.isEmpty
                          ? const Icon(Icons.person, size: 30, color: Colors.grey)
                          : imageFromString(player.picture!),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${player.firstName ?? ''} ${player.lastName ?? ''}",
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    player.birthDate != null
                        ? formatDateOnly(player.birthDate!)
                        : "Nepoznat datum",
                    style: const TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  void _loadPlayers() async{
    await _paginationController.loadPage();
          _paginationController.items = _paginationController.items
            .where((element) => !selectedPlayers.any((p) => p.id == element.id))
            .toList();
  }


}