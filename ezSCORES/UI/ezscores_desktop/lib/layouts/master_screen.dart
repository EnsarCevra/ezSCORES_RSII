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
   Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("Zatvori"),
              onTap: () => {
                Navigator.pop(context)
              },
            ),
            ListTile(
              title: Text("Timovi"),
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TeamsListScreen()))
              },
            ),
            ListTile(
              title: Text("Korisnici"),
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> UsersListScreen()))
              },
            ),
          ],
        ),
      ),
      body: widget.child,
    );
  }
}