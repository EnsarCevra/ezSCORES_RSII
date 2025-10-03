import 'package:ezscores_desktop/models/enums/competitionType.dart';
import 'package:ezscores_desktop/models/recommender/recommendCompetitionSetup.dart';
import 'package:flutter/material.dart';

class CompetitionRecommendationDialog extends StatefulWidget {
  final Future<RecommendedCompetitionSetup> Function() getRecommendation;
  final void Function(RecommendedCompetitionSetup) onAccept;

  const CompetitionRecommendationDialog({
    super.key,
    required this.getRecommendation,
    required this.onAccept,
  });

  @override
  State<CompetitionRecommendationDialog> createState() =>
      _CompetitionRecommendationDialogState();
}

class _CompetitionRecommendationDialogState
    extends State<CompetitionRecommendationDialog> {
  bool _loading = false;
  bool _showRecommendation = false;
  RecommendedCompetitionSetup? _recommendation;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Preporučene postavke"),
      content: _loading
          ? const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text("Ovo može potrajati..."),
              ],
            )
          : !_showRecommendation
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                        "Želite li preporuku za određene postavke takmičenja?"),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Ne")),
                        ElevatedButton(
                          onPressed: _fetchRecommendation,
                          child: const Text("Da"),
                        ),
                      ],
                    )
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildRecommendationRow(
                        "Tip takmičenja", _recommendation!.competitionType!.displayName),
                    _buildRecommendationRow(
                        "Broj ekipa", _recommendation!.maxTeamCount.toString()),
                    _buildRecommendationRow(
                        "Broj igrača po ekipi", _recommendation!.maxPlayersPerTeam.toString()),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Odbij"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            widget.onAccept(_recommendation!);
                            Navigator.of(context).pop();
                          },
                          child: const Text("Prihvati"),
                        ),
                      ],
                    )
                  ],
                ),
    );
  }

  Widget _buildRecommendationRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
          Text(value),
        ],
      ),
    );
  }

  void _fetchRecommendation() async {
    setState(() {
      _loading = true;
    });

    final recommendation = await widget.getRecommendation();

    setState(() {
      _loading = false;
      _showRecommendation = true;
      _recommendation = recommendation;
    });
  }
}
