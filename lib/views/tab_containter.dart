import 'package:flutter/material.dart';
import 'package:saloon_app/main.dart';
import 'package:saloon_app/views/tabs/chat/chat_screen.dart';
import 'package:saloon_app/views/tabs/home/home_screen.dart';
import 'package:saloon_app/views/tabs/profile/profile_screen.dart';

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
  static const String routeName = "/tabContainer";
  final List<Map<String, Object>> _pages = [
    {
      'page': const HomeScreen(),
      "title": HomeScreen.pageName,
      "icon": Icons.home
    },
    {
      'page': const ChatScreen(),
      'title': ChatScreen.pageName,
      "icon": Icons.accessibility
    },
    {
      'page': const ProfileScreen(),
      'title': ProfileScreen.pageName,
      "icon": Icons.person
    }
  ];
  @override
  State<ContainerPage> createState() => _ContainerPage();
}

class _ContainerPage extends State<ContainerPage> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._pages[_selectedPageIndex]['title'] as String),
        automaticallyImplyLeading: false,
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
          BottomNavigationBarItem(
              icon: Icon(Icons.person_pin), label: 'Profile'),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
