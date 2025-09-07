import 'package:ezscores_mobile/helpers/app_loading_widget.dart';
import 'package:ezscores_mobile/helpers/pagination/pagination_controller.dart';
import 'package:ezscores_mobile/models/DTOs/matchesByDateDto.dart';
import 'package:ezscores_mobile/models/matches.dart';
import 'package:ezscores_mobile/providers/MatchesProvider.dart';
import 'package:ezscores_mobile/providers/auth_provider.dart';
import 'package:ezscores_mobile/screens/applications_list_screen.dart';
import 'package:ezscores_mobile/screens/favorites_screen.dart';
import 'package:ezscores_mobile/screens/match_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:ezscores_mobile/providers/utils.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late MatchesProvider matchesProvider;
  Matches? match;

  late PaginationController<MatchesByDateDTO> _paginationController;
  final ScrollController _matchesScrollController = ScrollController();

  DateTime _selectedDate = DateTime.now(); 
  final int _dayRange = 10;
  final ScrollController _dateScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    matchesProvider = context.read<MatchesProvider>();
    _paginationController = PaginationController<MatchesByDateDTO>(
      fetchPage: (page, pageSize) {
        var filter = {
          "dateTime" : _selectedDate.toIso8601String(),
          "page": page,
          "pageSize": pageSize,
        };
        return matchesProvider.getMatchesByDate(filter: filter);
      },
    );
    _paginationController.addListener(() {
      setState(() {});
    });

    _paginationController.loadPage();

    _matchesScrollController.addListener(() {
      if (_matchesScrollController.position.pixels >= _matchesScrollController.position.maxScrollExtent - 100) {
        _paginationController.loadMore();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      const itemWidth = 42.0;

      final todayIndex = _dayRange;

      final offset = todayIndex * itemWidth - screenWidth / 2 + itemWidth / 2;

      _dateScrollController.jumpTo(offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(fontSize: 15),
        ),
        actions: const [LogoutButton()],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(AuthProvider.isLoggedIn())_buildHeader(),
          if(AuthProvider.isLoggedIn())_buildNavigationButtons(),
          const Divider(),
          _buildMainContent(),
        ],
      ),
    );
  }
  
  _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if(AuthProvider.roleName == 'Manager' || AuthProvider.roleName == 'Admin')ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => ApplicationsListScreen()
                )
              )
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
                horizontal: 24, vertical: 12),
          ),
          child: const Text("Prijave"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => FavoriteCompetitionsListScreen()
                )
              )
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
                horizontal: 24, vertical: 12),
          ),
          child: const Text("Favoriti"),
        ),
      ],
    );
  }
  
  _buildHeader() {
    final userFirstName = AuthProvider.firstName ?? "Korisniče";
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: Text(
        "Dobrodošao nazad, $userFirstName",
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
  
  _buildMainContent() {
    return Expanded(
      child: Column(
        children: [
          _buildSubHeader('Utakmice'),
          const SizedBox(height: 5,),
          _buildFilterByDate(),
          const SizedBox(height: 5,),
          Expanded(child:_buildMatchesView()),
        ],
      )
    );
  }
  
  Widget _buildFilterByDate() {
    final today = DateTime.now();
    final dates = List.generate(
      _dayRange * 2 + 1,
      (index) => today.subtract(Duration(days: _dayRange - index)),
    );

    return SizedBox(
      height: 36,
      child: ListView.builder(
        controller: _dateScrollController,
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date = dates[index];
          final isSelected = date.year == _selectedDate.year &&
              date.month == _selectedDate.month &&
              date.day == _selectedDate.day;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = date;
                _paginationController.loadPage();
              });
            },
            child: Container(
              width: 42,
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _getWeekdayShort(date),
                    style: TextStyle(
                      fontSize: 9,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                  Text(
                    "${date.day}.${date.month}.",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }


  String _getWeekdayShort(DateTime date) {
    const weekdays = ["Pon", "Uto", "Sri", "Čet", "Pet", "Sub", "Ned"];
    return weekdays[date.weekday - 1];
  }
  
  _buildMatchesView() {
    return AnimatedBuilder(
      animation: _paginationController,
      builder: (context, _) {
        if (_paginationController.isLoading && _paginationController.items.isEmpty) {
          return const AppLoading();
        }

        if (_paginationController.items.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Nema utakmica!"),
                Text("Pokušajte promijenuti datum!"),
              ],
            ),
          );
        }

        return ListView.builder(
          controller: _matchesScrollController,
          itemCount: _paginationController.items.length + (_paginationController.hasNext ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < _paginationController.items.length) {
              final dto = _paginationController.items[index];
              return _buildCompetitionMatchesCard(context, dto);
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
  _buildCompetitionMatchesCard(BuildContext context, MatchesByDateDTO dto) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        _buildSubHeader(dto.competition!.name!),
        Column(
          children: dto.matches!.map((match) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          MatchDetailsScreen(
                        matchID: match.matchId,
                        competition: dto.competition!,
                        fixtureId: match.fixtureId!,
                      ),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 55,
                        child: Text(
                          "${formatDateOnly(match.dateAndTime)}\n${formatTimeOnly(match.dateAndTime)}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                  
                      const SizedBox(width: 12),
                  
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  color: Colors.grey.shade300,
                                  margin: const EdgeInsets.only(right: 6),
                                ),
                                Expanded(
                                  child: Text(
                                    match.homeTeam?.name ?? "?",
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  color: Colors.grey.shade300,
                                  margin: const EdgeInsets.only(right: 6),
                                ),
                                Expanded(
                                  child: Text(
                                    match.awayTeam?.name ?? "?",
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            match.isCompleted == true
                                ? "${match.homeTeamScore ?? '-'}"
                                : "-",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            match.isCompleted == true
                                ? "${match.awayTeamScore ?? '-'}"
                                : "-",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
  _buildSubHeader(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
      color: Colors.blue,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );  
  }
}
