import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/models/competitions.dart';
import 'package:ezscores_desktop/providers/CompetitionsProvider.dart';
import 'package:ezscores_desktop/screens/tournament_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CompetitionMatchesTab extends StatefulWidget {
  final int? competitionId;
  final int selectedIndex;
  final int tabIndex;
  const CompetitionMatchesTab({super.key, this.competitionId, required this.selectedIndex, required this.tabIndex});

  @override
  State<CompetitionMatchesTab> createState() => _CompetitionMatchesTabState();
}

class _CompetitionMatchesTabState extends State<CompetitionMatchesTab> {
  Competitions? competition;
  late CompetitionProvider competitionProvider;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    competitionProvider = context.read<CompetitionProvider>();
    //_fetchData();
  }

  Future<void> _fetchData() async {
    if (widget.competitionId != null) {
      final data = await competitionProvider.getById(widget.competitionId!);
      setState(() {
        competition = data;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('mecevi'));
  }
}
