import 'package:ezscores_mobile/helpers/pagination/pagination_controller.dart';
import 'package:ezscores_mobile/models/competitions.dart';
import 'package:ezscores_mobile/models/enums/competitionStatus.dart';
import 'package:ezscores_mobile/models/enums/competitionType.dart';
import 'package:ezscores_mobile/models/reviews.dart';
import 'package:ezscores_mobile/models/search_result.dart';
import 'package:ezscores_mobile/providers/CompetitionsProvider.dart';
import 'package:ezscores_mobile/providers/utils.dart';
import 'package:ezscores_mobile/screens/competition_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class CompetitionsListScreen extends StatefulWidget {
  @override
  State<CompetitionsListScreen> createState() => _CompetitionsListScreenState();
}

class _CompetitionsListScreenState extends State<CompetitionsListScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _searchController = TextEditingController();
  late CompetitionProvider competitionProvider;
  SearchResult<Competitions>? competitionsResult;
  int? selectedStatus;
  int? selectedCompetitionType;

  late PaginationController<Competitions> _paginationController;
  final ScrollController _scrollController = ScrollController();

  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
    competitionProvider = context.read<CompetitionProvider>();
    _paginationController = PaginationController<Competitions>(
      fetchPage: (page, pageSize) {
        var filter = {
          "name": _searchController.text,
          "status" : selectedStatus,
          "competitionType" : selectedCompetitionType,
          "page": page,
          "pageSize": pageSize,
        };
        return competitionProvider.get(filter: filter);
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
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20,),
              TextField(
                controller: _searchController,
                style: textTheme.bodySmall,
                decoration: InputDecoration(
                  labelText: "Naziv takmičenja",
                  labelStyle: textTheme.bodySmall,
                  prefixIcon: const Icon(Icons.search, size: 18),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  suffixIcon: _searchController.text != ""
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
                      name: 'competitionStatus',
                      decoration: InputDecoration(
                        labelText: 'Status',
                        labelStyle: textTheme.bodySmall,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        suffixIcon: selectedStatus != null
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                selectedStatus = null;
                                _formKey.currentState
                                    ?.fields['competitionStatus']
                                    ?.reset();
                              });
                            },
                          )
                        : null,
                      ),
                      items: CompetitionStatus.values
                          .map((status) => DropdownMenuItem<int>(
                                value: status.value,
                                child: Text(
                                  status.displayName,
                                  style: textTheme.bodySmall,
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() => selectedStatus = value);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FormBuilderDropdown<int>(
                      name: 'competitionType',
                      decoration: InputDecoration(
                        labelText: 'Vrsta',
                        labelStyle: textTheme.bodySmall,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        suffixIcon: selectedCompetitionType != null
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                selectedCompetitionType = null;
                                _formKey.currentState
                                    ?.fields['competitionType']
                                    ?.reset();
                              });
                            },
                          )
                        : null,
                      ),
                      items: CompetitionType.values
                          .map((type) => DropdownMenuItem<int>(
                                value: type.value,
                                child: Text(
                                  type.displayName,
                                  style: textTheme.bodySmall,
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() => selectedCompetitionType = value);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: _paginationController.loadPage,
                    icon: const Icon(Icons.filter_alt, size: 18),
                    label: const Text("Filtriraj", style: TextStyle(fontSize: 13)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Expanded(child: _buildCompetitionsResultView()),
            ],
          ),
        ),
      ),
    );
  }
  
  _buildCompetitionsResultView() {
    return AnimatedBuilder(
      animation: _paginationController,
      builder: (context, _) {
        if (_paginationController.isLoading && _paginationController.items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_paginationController.items.isEmpty) {
          return const Center(child: Text("Nema podataka"));
        }

        return ListView.builder(
            controller: _scrollController,
            itemCount: _paginationController.items.length + (_paginationController.hasNext ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < _paginationController.items.length) {
                final competition = _paginationController.items[index];
                return _buildCompetitionCard(context, competition);
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          );
      },
    );
  }
  _buildCompetitionCard(BuildContext context, Competitions competition) {
        final textTheme = Theme.of(context).textTheme;

        return InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => CompetitionsDetailsScreen(competition.id)
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
                            child: competition.picture == null || competition.picture!.isEmpty ?
                             const Icon(Icons.emoji_events, size: 30, color: Colors.grey) :
                             imageFromString(competition.picture!)
                          )
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          competition.name ?? "Nepoznato takmičenje",
                          style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          competition.competitionType?.displayName ?? "",
                          style: textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star, size: 16, color: Colors.amber),
                            const SizedBox(width: 2),
                            Text(
                              "${_getAverageRating(competition.reviews)}"
                              " (${competition.reviews?.length ?? 0} ${(competition.reviews?.length == 2 || competition.reviews?.length == 3 || competition.reviews?.length == 4)?'ocjene' : 'ocjena' })",
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
                          competition.status?.displayName.toUpperCase() ?? "",
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
