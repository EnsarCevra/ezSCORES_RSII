import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget
{
  const ProfileScreen({super.key});

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
    return MasterScreen("Korisnički profil", Placeholder(), selectedIndex: 5,);
  }
}