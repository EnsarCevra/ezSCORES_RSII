import 'package:ezscores_desktop/main.dart';
import 'package:ezscores_desktop/providers/auth_provider.dart';
import 'package:ezscores_desktop/screens/admin_dashboard_screen.dart';
import 'package:ezscores_desktop/screens/admin_setting_screen.dart';
import 'package:ezscores_desktop/screens/competitions_list_screen.dart';
import 'package:ezscores_desktop/screens/profile_screen.dart';
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
    case 0: screenToPush = const AdminDashboardScreen();
    case 1: screenToPush = CompetitionsListScreen(selectedIndex: index,);
    case 5: screenToPush = AdminSettingsScreen(selectedIndex: index,);
    case 6:  screenToPush = UsersListScreen(selectedIndex: index,);
    case 7:  screenToPush = ProfileScreen(selectedIndex: index,);
      break;
    default:
      return;
  }

  final result = await Navigator.of(context).push<int>(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screenToPush!,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );

    if (result != null) {
      setState(() {
        _currentIndex = result;
      });
    }
}
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Row(
      children: [
        Container(
          width: 250,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            children: [
              // Logo at the top
              Row(
                children: [
                  Image.asset("assets/images/ezlogo5.png", height: 75, width: 75),
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
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _SidebarItem(
                              index: 0,
                              icon: Icons.dashboard,
                              title: "Dashboard",
                              isSelected: widget.selectedIndex == 0,
                              onTap: () => onSidebarItemTapped(0),
                            ),
                            _SidebarItem(
                              index: 1,
                              icon: Icons.event,
                              title: "Upravljaj takmičenjima",
                              isSelected: widget.selectedIndex == 1,
                              onTap: () => onSidebarItemTapped(1),
                            ),
                            if (AuthProvider.roleID == 3)
                              _SidebarItem(
                                index: 5,
                                icon: Icons.settings_applications_outlined,
                                title: "Admin postavke",
                                isSelected: widget.selectedIndex == 5,
                                onTap: () => onSidebarItemTapped(5),
                              ),
                            if (AuthProvider.roleID == 3)
                              _SidebarItem(
                                index: 6,
                                icon: Icons.supervised_user_circle_sharp,
                                title: "Korisnici",
                                isSelected: widget.selectedIndex == 6,
                                onTap: () => onSidebarItemTapped(6),
                              ),
                          ],
                        ),
                      ),
                    ),

                    const Divider(height: 20),
                    _SidebarItem(
                      index: 7,
                      icon: Icons.person_outline,
                      title: "Profil",
                      isSelected: widget.selectedIndex == 7,
                      onTap: () => onSidebarItemTapped(7),
                    ),
                    _SidebarItem(
                      index: 8,
                      icon: Icons.logout,
                      title: "Odjavi se",
                      isSelected: widget.selectedIndex == 8,
                      onTap: () => logOut(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: Column(
            children: [
              AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop(_currentIndex);
                    }
                  },
                ),
                title: Text(widget.title),
                automaticallyImplyLeading: false,
              ),
              Expanded(child: widget.child),
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
    AuthProvider.organization= null;
    AuthProvider.roleID = null;
    AuthProvider.roleDecription = null;
    AuthProvider.roleName = null;                                
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MyApp()));
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
      margin: const EdgeInsets.only(bottom: 6),
      decoration: isSelected
          ? BoxDecoration(
              color: Colors.blue,
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

