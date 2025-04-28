import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/screens/cities_list_screen.dart';
import 'package:ezscores_desktop/screens/selections_list_screen.dart';
import 'package:flutter/material.dart';

class AdminSettingsScreen extends StatelessWidget {
  final int selectedIndex;
  const AdminSettingsScreen({super.key, required this.selectedIndex});
  @override
  Widget build(BuildContext context) {
    final List<_AdminCardItem> cardItems = [
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
      _AdminCardItem("Upravljaj stadionima", Icons.stadium, () {
        // Navigate to player management
      }),
      _AdminCardItem("Upravljaj sponzorima", Icons.monetization_on, () {
        // Navigate to tournament management
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
          final double cardWidth = 250;
          final double cardHeight = 120;
          final double spacing = 24;
          final int crossAxisCount = 2;

          // Calculate total grid width
          final double totalWidth = (crossAxisCount * cardWidth) + ((crossAxisCount - 1) * spacing);
          final double horizontalPadding = (constraints.maxWidth - totalWidth) / 2;

          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 32),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
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
              SizedBox(height: 8),
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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