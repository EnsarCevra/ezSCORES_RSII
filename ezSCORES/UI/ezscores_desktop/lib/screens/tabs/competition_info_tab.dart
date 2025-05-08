import 'package:ezscores_desktop/models/competitions.dart';
import 'package:ezscores_desktop/providers/CompetitionsProvider.dart';
import 'package:ezscores_desktop/screens/tournament_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CompetitionInfoTab extends StatefulWidget {
  final int selectedIndex;
  final int tabIndex;
  Competitions? competition;
  CompetitionInfoTab({super.key, required this.selectedIndex, required this.tabIndex, this.competition});

  @override
  State<CompetitionInfoTab> createState() => _CompetitionInfoTabState();
}

class _CompetitionInfoTabState extends State<CompetitionInfoTab> {
  Competitions? competition;
  late CompetitionProvider competitionProvider;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    competitionProvider = context.read<CompetitionProvider>();
    //_fetchData();
  }

  // Future<void> _fetchData() async {
  //   if (widget.competitionId != null) {
  //     final data = await competitionProvider.getById(widget.competitionId!);
  //     setState(() {
  //       competition = data;
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    //return MasterScreen("Detalji", Center(child: Text('info')), selectedIndex: widget.selectedIndex);
    return Center(child: Text('mecevi'));
  }
}
