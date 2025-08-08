import 'package:ezscores_mobile/models/competitions.dart';
import 'package:ezscores_mobile/models/enums/competitionStatus.dart';
import 'package:ezscores_mobile/models/enums/competitionType.dart';
import 'package:ezscores_mobile/models/reviews.dart';
import 'package:ezscores_mobile/models/search_result.dart';
import 'package:ezscores_mobile/providers/CompetitionsProvider.dart';
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

  void initState() {
    super.initState();
    competitionProvider = context.read<CompetitionProvider>();
    _loadData();
  }
   Future<void> _loadData() async
   {
      final filters = {
        "name": _searchController.text,
        "status": selectedStatus,
        "competitionType": selectedCompetitionType,
        "isReviewsIncluded" : true,
      };
      var competitionData = await competitionProvider.get(filter: filters);
      setState(() {
      competitionsResult = competitionData;
    });
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
                    onPressed: _loadData,
                    icon: const Icon(Icons.filter_alt, size: 18),
                    label: const Text("Filtriraj", style: TextStyle(fontSize: 13)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              _buildCompetitionsResultView(),
            ],
          ),
        ),
      ),
    );
  }
  
  _buildCompetitionsResultView() {
    return Expanded(
      child: competitionsResult == null
          ? const Center(child: CircularProgressIndicator())
          : competitionsResult!.result.isEmpty
              ? const Center(
                  child: Text(
                    "Nema rezultata.",
                  ),
                )
              : ListView.separated(
                  itemCount: competitionsResult!.result.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final competition = competitionsResult!.result[index];
                    return _buildCompetitionCard(context, competition);
                  },
                ),
    );
  }
  _buildCompetitionCard(BuildContext context, Competitions competition) {
        final textTheme = Theme.of(context).textTheme;

        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                // Competition image (placeholder)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: competition.picture == null || competition.picture!.isEmpty
                      ? Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey[300],
                          child: const Icon(Icons.emoji_events, size: 30, color: Colors.grey),
                        )
                      : Image.network(
                          competition.picture!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 60,
                              height: 60,
                              color: Colors.grey[300],
                              child: const Icon(Icons.emoji_events, size: 30, color: Colors.grey),
                            );
                          },
                        ),
                ),
                const SizedBox(width: 12),
                // Title and subtitle
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
                // Status and favorite icon
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
