import 'package:flutter/material.dart';
import 'package:saloon_app/views/authentification/login/login.dart';
import 'package:saloon_app/views/tabs/home/home_screen.dart';
import 'package:saloon_app/views/tab_containter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String pageName = "HomeScreen";

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContainerPage(title: 'Flutter Demo Home Page'),
      routes: {
        Login.routeName: (ctx) => const Login(),
        ContainerPage.routeName: (ctx) =>
            ContainerPage(title: 'Flutter Demo Home Page')
      },
      initialRoute: Login.routeName,
    );
  }
}
