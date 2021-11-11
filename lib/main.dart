import 'package:flutter/material.dart';
import 'package:saloon_app/views/authentification/login/login.dart';
import 'package:saloon_app/views/home_screen/home_screen.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: ContainerPage(title: 'Flutter Demo Home Page'),
      routes: {
        Login.routeName: (ctx) => const Login(),
      },
      initialRoute: Login.routeName,
    );
  }
}

class ContainerPage extends StatefulWidget {
  ContainerPage({Key? key, required this.title}) : super(key: key);

  // This widget is the Container page of the application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // It containts the Scaffold, all other views (besides login) is in there.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final List<Map<String, Object>> _pages = [
    {'page': const HomeScreen(), "title": MyApp.pageName, "icon": Icons.add},
  ];
  @override
  State<ContainerPage> createState() => _ContainerPage();
}

class _ContainerPage extends State<ContainerPage> {
  int _selectedPageIndex = 0;

  void _selectPage(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: widget._pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.green,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_pin), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.sanitizer), label: 'Profile')
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
