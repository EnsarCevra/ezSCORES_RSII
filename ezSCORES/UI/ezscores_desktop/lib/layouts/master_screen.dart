import 'package:ezscores_desktop/screens/teams_list.dart';
import 'package:ezscores_desktop/screens/users_list.dart';
import 'package:flutter/material.dart';

class MasterScreen extends StatefulWidget
{
  MasterScreen(this.title, this.child,{super.key});
  String title;
  Widget child;

  @override
  State<MasterScreen> createState() => _MasterScreenState();
 
}

class _MasterScreenState extends State<MasterScreen>
{
     @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Row(
      children: [
        // Sidebar
        Container(
          width: 200, // Adjust width as needed
          color: Colors.greenAccent[900],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.blue,
                child: const Text(
                  "Navigacija",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              ListTile(
                title: const Text("Timovi", style: TextStyle(color: Colors.blue)),
                leading: const Icon(Icons.group, color: Colors.white),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => TeamsListScreen()));
                },
              ),
              ListTile(
                title: const Text("Korisnici", style: TextStyle(color: Colors.blue)),
                leading: const Icon(Icons.person, color: Colors.white),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => UsersListScreen()));
                },
              ),
              const Spacer(),
              ListTile(
                title: const Text("Zatvori", style: TextStyle(color: Colors.blue)),
                leading: const Icon(Icons.close, color: Colors.white),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),

        // Main content
        Expanded(
          child: Column(
            children: [
              AppBar(
                title: Text(widget.title),
                automaticallyImplyLeading: false, // hides the hamburger icon
              ),
              Expanded(child: widget.child),
            ],
          ),
        ),
      ],
    ),
  );
}

}