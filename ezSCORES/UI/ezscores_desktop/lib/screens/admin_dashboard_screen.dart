import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget
{
  const AdminDashboardScreen({super.key});

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
    return MasterScreen("Dashboard", Placeholder(), selectedIndex: 0,);
  }
}