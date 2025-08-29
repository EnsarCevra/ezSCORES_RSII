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
  int _previousIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    CompetitionsListScreen(),
    TeamsListScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, animation) {
          final isForward = _selectedIndex >= _previousIndex;
          final offsetAnimation = Tween<Offset>(
            begin: Offset(isForward ? 1 : -1, 0),
            end: Offset.zero,
          ).animate(animation);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        child: _screens[_selectedIndex],
        layoutBuilder: (currentChild, previousChildren) {
          return Stack(
            children: <Widget>[
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          );
        },
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
          onTabChange: (index) {
            setState(() {
              _previousIndex = _selectedIndex;
              _selectedIndex = index;
            });
          },
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
