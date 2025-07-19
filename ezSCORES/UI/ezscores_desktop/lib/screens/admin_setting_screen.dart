import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/screens/cities_list_screen.dart';
import 'package:ezscores_desktop/screens/players_list_screen.dart';
import 'package:ezscores_desktop/screens/referees_list.screen.dart';
import 'package:ezscores_desktop/screens/selections_list_screen.dart';
import 'package:ezscores_desktop/screens/sponsors_list_screen.dart';
import 'package:ezscores_desktop/screens/stadiums_list_screen.dart';
import 'package:ezscores_desktop/screens/teams_list.dart';
import 'package:flutter/material.dart';

class AdminSettingsScreen extends StatelessWidget {
  final int selectedIndex;
  const AdminSettingsScreen({super.key, required this.selectedIndex});
  @override
  Widget build(BuildContext context) {
    final List<_AdminCardItem> cardItems = [
      _AdminCardItem("Upravljaj ekipama", Icons.people, () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => TeamsListScreen(selectedIndex: selectedIndex),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      }),
      _AdminCardItem("Upravljaj igračima", Icons.people, () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => PlayersListScreen(selectedIndex: selectedIndex),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      }),
      _AdminCardItem("Upravljaj selekcijama", Icons.group_add, () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => SelectionsListScreen(selectedIndex: selectedIndex),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      }),
      _AdminCardItem("Upravljaj sudcima", Icons.safety_check, () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => RefereesListScreen(selectedIndex: selectedIndex),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      }),
      _AdminCardItem("Upravljaj stadionima", Icons.stadium, () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => StadiumsListScreen(selectedIndex: selectedIndex),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      }),
      _AdminCardItem("Upravljaj sponzorima", Icons.handshake, () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => SponsorsListScreen(selectedIndex: selectedIndex),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      }),
      _AdminCardItem("Upravljaj gradovima", Icons.location_city, () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => CitiesListScreen(selectedIndex: selectedIndex),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      }),
    ];

    return MasterScreen(
      "Admin postavke",
      selectedIndex: selectedIndex, 
      LayoutBuilder(
        builder: (context, constraints) {
          const double cardWidth = 250;
          const double cardHeight = 120;
          const double spacing = 24;
          const int crossAxisCount = 3;

          // Calculate total grid width
          const  double totalWidth = (crossAxisCount * cardWidth) + ((crossAxisCount - 1) * spacing);
          final double horizontalPadding = (constraints.maxWidth - totalWidth) / 2;

          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 32),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cardItems.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: spacing,
                    mainAxisSpacing: spacing,
                    childAspectRatio: cardWidth / cardHeight,
                  ),
                  itemBuilder: (context, index) {
                    return _buildCard(context, cardItems[index], cardWidth, cardHeight);
                  },
                ),
              ),
            ),
          );
        },
),

    );
  }

  Widget _buildCard(BuildContext context, _AdminCardItem item, double width, double height) {
  return SizedBox(
    width: width,
    height: height,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: item.onTap,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, size: 36, color: Colors.blueAccent),
              const SizedBox(height: 8),
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


}

class _AdminCardItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  _AdminCardItem(this.title, this.icon, this.onTap);
}