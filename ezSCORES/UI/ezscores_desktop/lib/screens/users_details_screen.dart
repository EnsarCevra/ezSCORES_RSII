import 'package:ezscores_desktop/layouts/master_screen.dart';
import 'package:ezscores_desktop/models/users.dart';
import 'package:flutter/material.dart';

class UsersDetailsScreen extends StatelessWidget
{
  Users? user;
  UsersDetailsScreen({super.key, this.user});

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
    return MasterScreen("UserDetails", Placeholder(), selectedIndex: 5,);
  }
}