import 'package:ezscores_mobile/helpers/app_loading_widget.dart';
import 'package:ezscores_mobile/helpers/pagination/pagination_controller.dart';
import 'package:ezscores_mobile/models/enums/competitionStatus.dart';
import 'package:ezscores_mobile/models/enums/competitionType.dart';
import 'package:ezscores_mobile/models/favoriteCompetitions.dart';
import 'package:ezscores_mobile/models/reviews.dart';
import 'package:ezscores_mobile/providers/FavoriteCompetitionsProvider.dart';
import 'package:ezscores_mobile/providers/utils.dart';
import 'package:ezscores_mobile/screens/competition_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteCompetitionsListScreen extends StatefulWidget {
  @override
  State<FavoriteCompetitionsListScreen> createState() => _FavoriteCompetitionsListScreenState();
}

class _FavoriteCompetitionsListScreenState extends State<FavoriteCompetitionsListScreen> {
  final TextEditingController _searchController = TextEditingController();
  late FavoriteCompetitionsProvider favoriteCompetitionsProvider;
  int? selectedStatus;
  int? selectedCompetitionType;

  late PaginationController<FavoriteCompetitions> _paginationController;
  final ScrollController _scrollController = ScrollController();

  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
    favoriteCompetitionsProvider = context.read<FavoriteCompetitionsProvider>();
    _paginationController = PaginationController<FavoriteCompetitions>(
      fetchPage: (page, pageSize) {
        var filter = {
          "name": _searchController.text,
          "page": page,
          "pageSize": pageSize,
        };
        return favoriteCompetitionsProvider.get(filter: filter);
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
        title: const Text("Spašena takmičenja",
        style: TextStyle(fontSize: 15),),
        actions: const [LogoutButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Column(
          children: [
            Expanded(child: _buildCompetitionsResultView())
          ],
        ),
      ),
    );
  }
  _buildCompetitionsResultView() {
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
                final favoriteCompetitions = _paginationController.items[index];
                return _buildCompetitionCard(context, favoriteCompetitions);
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
  _buildCompetitionCard(BuildContext context, FavoriteCompetitions favoriteCompetitions) {
        final textTheme = Theme.of(context).textTheme;

        return InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => CompetitionsDetailsScreen(favoriteCompetitions.competitionId)
                )
              )
            );
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
                            child: favoriteCompetitions.competition!.picture == null || favoriteCompetitions.competition!.picture!.isEmpty ?
                             const Icon(Icons.emoji_events, size: 30, color: Colors.grey) :
                             imageFromString(favoriteCompetitions.competition!.picture!)
                          )
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          favoriteCompetitions.competition!.name ?? "Nepoznato takmičenje",
                          style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          favoriteCompetitions.competition!.competitionType?.displayName ?? "",
                          style: textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star, size: 16, color: Colors.amber),
                            const SizedBox(width: 2),
                            Text(
                              "${_getAverageRating(favoriteCompetitions.competition!.reviews)}"
                              " (${favoriteCompetitions.competition!.reviews?.length ?? 0} ${(favoriteCompetitions.competition!.reviews?.length == 2 || favoriteCompetitions.competition!.reviews?.length == 3 || favoriteCompetitions.competition!.reviews?.length == 4)?'ocjene' : 'ocjena' })",
                              style: textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 60,
                        child: Text(
                          favoriteCompetitions.competition!.status?.displayName.toUpperCase() ?? "",
                          style: textTheme.bodySmall?.copyWith(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.right,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Icon(Icons.star, color: Colors.amber),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
  double _getAverageRating(List<Reviews>? reviews) {
      if (reviews == null) return 0;

      final validReviews = reviews.where((r) => r.rating != null).toList();
      if (validReviews.isEmpty) return 0;

      final total = validReviews.map((r) => r.rating!).reduce((a, b) => a + b);
      return total / validReviews.length;
    }
}