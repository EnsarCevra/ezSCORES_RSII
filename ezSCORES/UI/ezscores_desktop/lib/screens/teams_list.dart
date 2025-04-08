import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:flutter/material.dart';

class TeamsListScreen extends StatelessWidget
{
  const TeamsListScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return MasterScreen("Lista timova", Column(
      children: [
        Text("Lista timova placeholder"),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text("Back"))
      ],
    ));
  }
}