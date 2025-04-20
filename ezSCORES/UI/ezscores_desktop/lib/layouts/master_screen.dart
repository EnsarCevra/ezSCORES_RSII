import 'package:ezscores_desktop/main.dart';
import 'package:ezscores_desktop/providers/auth_provider.dart';
import 'package:ezscores_desktop/screens/admin_dashboard_screen.dart';
import 'package:ezscores_desktop/screens/competitions_list_screen.dart';
import 'package:ezscores_desktop/screens/players_list_screen.dart';
import 'package:ezscores_desktop/screens/profile_screen.dart';
import 'package:ezscores_desktop/screens/teams_list.dart';
import 'package:ezscores_desktop/screens/users_list.dart';
import 'package:flutter/material.dart';

class MasterScreen extends StatefulWidget {
  MasterScreen(this.title, this.child, {super.key, required this.selectedIndex});
  String title;
  Widget child;
  int selectedIndex;
  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  late int _currentIndex;
  @override
  void initState()
  {
    super.initState();
    _currentIndex = widget.selectedIndex;
  }
   void onSidebarItemTapped(int index) async {
  setState(() {
    _currentIndex = index; 
  });

  Widget? screenToPush;
  switch (index) {
     case 0: screenToPush = AdminDashboardScreen();
     case 1: screenToPush = CompetitionsListScreen();
    case 2: screenToPush = TeamsListScreen(selectedIndex: index);
    case 3: screenToPush = PlayersListScreen();
    case 4: screenToPush = UsersListScreen();
    case 5: screenToPush = ProfileScreen();
      break;
    default:
      return;
  }

  if (screenToPush != null) {
    final result = await Navigator.of(context).push<int>(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screenToPush!,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );

    // Handle the selectedIndex on pop back
    if (result != null) {
      setState(() {
        _currentIndex = result;
      });
    }
  }
}

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 250,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset("assets/images/ezlogo5.png", height: 75, width: 75,),
                    const SizedBox(width: 12),
                    const Text(
                      "EZSCORES",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Sidebar Items
                _SidebarItem(
                  index: 0,
                  icon: Icons.dashboard,
                  title: "Dashboard",
                  isSelected: widget.selectedIndex == 0,
                  onTap: () => onSidebarItemTapped(0),
                ),
                _SidebarItem(
                  index: 1,
                  icon: Icons.bar_chart,
                  title: "Upravljaj takmičenjima",
                  isSelected: widget.selectedIndex == 1,
                  onTap: () => onSidebarItemTapped(1),
                ),
                _SidebarItem(
                  index: 2,
                  icon: Icons.assignment,
                  title: "Upravljaj ekipama",
                  isSelected: widget.selectedIndex == 2,
                  onTap: () => onSidebarItemTapped(2),
                ),
                _SidebarItem(
                  index: 3,
                  icon: Icons.groups,
                  title: "Upravljaj igračima",
                  isSelected: widget.selectedIndex == 3,
                  onTap: () => onSidebarItemTapped(3),
                ),
                _SidebarItem(
                  index: 4,
                  icon: Icons.calendar_today,
                  title: "Korisnici",
                  isSelected: widget.selectedIndex == 4,
                  onTap: () => onSidebarItemTapped(4),
                ),
                const Divider(height: 40),
                _SidebarItem(
                  index: 5,
                  icon: Icons.person_outline,
                  title: "Profil",
                  isSelected: widget.selectedIndex == 5,
                  onTap: () => onSidebarItemTapped(5),
                ),
                _SidebarItem(
                  index: 6,
                  icon: Icons.logout,
                  title: "Odjavi se",
                  isSelected: widget.selectedIndex == 6,
                  onTap: () => logOut(),
                ),
              ],
            ),
          ),

          // Main content area
          Expanded(
            child: Column(
              children: [
                AppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      if(Navigator.of(context).canPop())
                      {
                       Navigator.of(context).pop(_currentIndex);
                      }
                    },
                  ),
                  title: Text(widget.title),
                  automaticallyImplyLeading: false,
                ),
                Expanded(child: widget.child)
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  logOut() {
    AuthProvider.username = "";
    AuthProvider.password = "";
    AuthProvider.id = null;
    AuthProvider.firstName = null;
    AuthProvider.lastName = null;
    AuthProvider.userName = null;
    AuthProvider.picture = null;
    AuthProvider.email = null;
    AuthProvider.phoneNumber = null;                            
    AuthProvider.orzanization= null;                                
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyApp()));
    setState(() {});                                                       
  }
}

class _SidebarItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.index,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: isSelected
          ? BoxDecoration(
              color: const Color(0xFF28A745),
              borderRadius: BorderRadius.circular(8),
            )
          : null,
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.grey[700],
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[800],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

