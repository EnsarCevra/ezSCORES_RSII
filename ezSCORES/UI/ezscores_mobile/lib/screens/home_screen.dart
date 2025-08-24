import 'package:ezscores_mobile/providers/utils.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home", style: TextStyle(fontSize: 15),),
        actions: const [LogoutButton()],
      ),
      body: Center(child: Text('Home screen'),)
    );
  }
}
