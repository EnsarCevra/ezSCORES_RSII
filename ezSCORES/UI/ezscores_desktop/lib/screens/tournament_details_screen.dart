import 'package:ezscores_desktop/models/competitions.dart';
import 'package:ezscores_desktop/models/enums/competitionStatus.dart';
import 'package:ezscores_desktop/models/enums/competitionType.dart';
import 'package:ezscores_desktop/screens/tabs/applications_tab.dart';
import 'package:ezscores_desktop/screens/tabs/competition_details_info_tab.dart';
import 'package:ezscores_desktop/screens/tabs/matches_tab.dart';
import 'package:ezscores_desktop/screens/tabs/standings_tab.dart';
import 'package:flutter/material.dart';
import 'package:ezscores_desktop/layouts/master_screen.dart';

class CompetitionsDetailsScreen extends StatefulWidget {
  final int selectedIndex;
  Competitions? competition;

  CompetitionsDetailsScreen({
    super.key,
    required this.selectedIndex,
    this.competition,
  });

  @override
  State<CompetitionsDetailsScreen> createState() => _CompetitionsDetailsScreenState();
}

class _CompetitionsDetailsScreenState extends State<CompetitionsDetailsScreen> {
  int _tabIndex = 0;

  final List<String> _tabs = ['Informacije', 'Prijave', 'Poredak', 'Utakmice'];

  Widget _buildNavbar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final isSelected = index == _tabIndex;
          final isEnabled = _isTabEnabled(index);
          return Expanded(
            child: GestureDetector(
              onTap: isEnabled ? () {
                setState(() {
                  _tabIndex = index;
                });
              } : null,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? Colors.blue : Colors.transparent,
                      width: 3,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    _tabs[index],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isEnabled ? (isSelected ? Colors.blue : Colors.black) : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_tabIndex) {
      case 0: return _buildInfoContent();
      case 1: return _buildApplicationsContent();
      case 2: return _buildStandingsContent();
      case 3: return _buildMatchesContent();
      default:
        return const Center(child: Text('Nepoznata kartica'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      widget.competition != null ? "Detalji takmičenja" : "Novo takmičenje",
      selectedIndex: widget.selectedIndex,
      Column(
        children: [
          if (widget.competition != null) _buildNavbar(),
          _buildTabContent(),
        ],
      ),
    );
  }
  
  _isTabEnabled(int index) {
    switch (index) {
    case 0: return true; 
    case 1: return widget.competition!.status! == CompetitionStatus.applicationsOpen || widget.competition!.status! == CompetitionStatus.applicationsClosed || widget.competition!.status! == CompetitionStatus.underway ||widget.competition!.status! == CompetitionStatus.finished;
    case 2: return (widget.competition!.competitionType == CompetitionType.league || widget.competition!.competitionType == CompetitionType.tournament) && (widget.competition!.status! == CompetitionStatus.applicationsClosed || widget.competition!.status! == CompetitionStatus.underway ||widget.competition!.status! == CompetitionStatus.finished);
    case 3: return widget.competition!.status! == CompetitionStatus.applicationsClosed || widget.competition!.status! == CompetitionStatus.underway ||widget.competition!.status! == CompetitionStatus.finished;
    default:
      return false;
  }
  }

  Widget _buildInfoContent()
  {
    return CompetitionDetailsTab(competition: widget.competition,);
  }
  Widget _buildApplicationsContent()
  {
    return ApplicationsTab(competitionId: widget.competition!.id!);
  }
  Widget _buildStandingsContent()
  {
    return Expanded(child: StandingsTab(competitionId: widget.competition!.id!, isLeague: widget.competition?.competitionType == CompetitionType.league ? true : false));
  }
  Widget _buildMatchesContent()
  {
    return Expanded(child: MatchesTab(competitionId: widget.competition!.id!,));
  }
}
