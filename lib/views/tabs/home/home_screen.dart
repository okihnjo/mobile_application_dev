import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String pageName = "HomeScreen";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Home"),
    );
  }
}
