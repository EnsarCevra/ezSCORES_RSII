import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:flutter/material.dart';

class CompetitionsListScreen extends StatelessWidget
{
  const CompetitionsListScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    // return MasterScreen("Lista korisnika", Column(
    //   children: [
    //     Text("Lista korisnika placeholder"),
    //     SizedBox(height: 10,),
    //     ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text("Back"))
    //   ],
    // ));
    return MasterScreen("Lista takmičenja", Placeholder(), selectedIndex: 1,);
  }
}