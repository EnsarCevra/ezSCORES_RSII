import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  final Color? backgroundColor;
  const AppLoading({super.key, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
