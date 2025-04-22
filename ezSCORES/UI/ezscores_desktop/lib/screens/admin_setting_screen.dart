import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:flutter/material.dart';

class AdminSettingsScreen extends StatelessWidget
{
  const AdminSettingsScreen({super.key});

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
    return MasterScreen("Admin postavke", Placeholder(), selectedIndex: 4,);
  }
}