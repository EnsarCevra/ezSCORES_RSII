import 'package:ezscores_mobile/screens/competitions_list_screen.dart';
import 'package:ezscores_mobile/screens/profile_screen.dart';
import 'package:ezscores_mobile/screens/home_screen.dart';
import 'package:ezscores_mobile/screens/teams_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainNavigationScreen extends StatefulWidget {
  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    CompetitionsListScreen(),
    TeamsListScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey.withOpacity(0.3),
              width: 0.5,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
        child: GNav(
          gap: 8,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          backgroundColor: Colors.white,
          color: Colors.grey[700],
          activeColor: Colors.white,
          tabBackgroundColor: Colors.blue,
          selectedIndex: _selectedIndex,
          onTabChange: (index) => setState(() => _selectedIndex = index),
          tabs: const [
            GButton(icon: Icons.home),
            GButton(icon: Icons.emoji_events),
            GButton(icon: Icons.people),
            GButton(icon: Icons.person),
          ],
        ),
      ),
    );
  }
}