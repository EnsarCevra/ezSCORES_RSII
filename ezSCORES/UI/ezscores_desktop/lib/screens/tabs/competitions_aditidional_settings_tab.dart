import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/screens/tabs/competition_referees_tab.dart';
import 'package:ezscores_desktop/screens/tabs/competition_sponsors_tab.dart';
import 'package:flutter/material.dart';

class CompetitionAditionalSettingsScreen extends StatefulWidget
{
  final int selectedIndex;
  final int competitionId;
  const CompetitionAditionalSettingsScreen({super.key, required this.selectedIndex, required this.competitionId});
  
  @override
  State<CompetitionAditionalSettingsScreen> createState() => _CompetitionAditionalSettingsScreenState();
}
class _CompetitionAditionalSettingsScreenState extends State<CompetitionAditionalSettingsScreen>
{
  int _tabIndex = 0;

  final List<String> _tabs = ['Sudci', 'Sponzori', 'Nagrade',];

  Widget _buildNavbar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final isSelected = index == _tabIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _tabIndex = index;
                });
              },
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
      case 0: return _buildRefereesContent();
      case 1: return _buildSponsorsContent();
      case 2: return _buildRewardsContent();
      default:
        return const Center(child: Text('Nepoznata kartica'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      "Dodatne postavke",
      selectedIndex: widget.selectedIndex,
      Column(
        children: [
          _buildNavbar(),
          _buildTabContent(),
        ],
      ),
    );
  }

  Widget _buildRefereesContent()
  {
    return Expanded(child: CompetitionRefereesTab(competitionId: widget.competitionId));
  }
  Widget _buildSponsorsContent()
  {
    return Expanded(child: CompetitionsSponsorsTab(competitionId: widget.competitionId));
  }
  Widget _buildRewardsContent()
  {
    return const Center(child: Text('Sponzori tab content'));
  }
}