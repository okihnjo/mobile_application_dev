import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saloon_app/main.dart';
import 'package:saloon_app/providers/user_provider.dart';
import 'package:saloon_app/services/user_service.dart';
import 'package:saloon_app/views/tabs/chat/chat_screen.dart';
import 'package:saloon_app/views/tabs/home/settings_screen.dart';
import 'package:saloon_app/views/tabs/profile/profile_screen.dart';
import 'package:permission_handler/permission_handler.dart';

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
      'page': const SettingsScreen(),
      "title": SettingsScreen.pageName,
      "icon": Icons.home
    },
    {
      'page': const ChatScreen(),
      'title': ChatScreen.pageName,
      "icon": Icons.accessibility
    },
    {
      'page': ProfileScreen(),
      'title': ProfileScreen.pageName,
      "icon": Icons.person
    }
  ];
  @override
  State<ContainerPage> createState() => _ContainerPage();
}

class _ContainerPage extends State<ContainerPage> {
  void initState() {
    super.initState();
    _askPermissions();
  }

  int _selectedPageIndex = 1;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      print("works");
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Object? user;

  displayContacts() {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Consumer(builder: (context, ref, child) {
          final contactsProvider = ref.watch(getContactsProvider);
          return FractionallySizedBox(
            heightFactor: 0.9,
            child: Container(
              color: Colors.amber,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    contactsProvider.when(
                      data: (data) {
                        return Expanded(
                          child: ListView.separated(
                              itemBuilder: (ctx, i) {
                                return FutureBuilder<Object>(
                                    future: checkIfUserHasApp(
                                        data[i].phones?[0].value as String),
                                    builder: (context, snap) {
                                      if (snap.hasData) {
                                        return ListTile(
                                            trailing: (snap.data
                                                    as Map)['hasApp'] as bool
                                                ? IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.of(context)
                                                          .pushNamed('/chat',
                                                              arguments: {
                                                            'user': (snap.data
                                                                as Map)['user']
                                                          });
                                                    },
                                                    icon: Icon(Icons.send))
                                                : Text(''),
                                            title: Text(
                                                data[i].displayName as String),
                                            subtitle: Text((snap.data
                                                    as Map)['hasApp'] as bool
                                                ? 'Hat'
                                                : 'Hat nicht'));
                                      } else {
                                        return Text("Loading");
                                      }
                                    });
                              },
                              separatorBuilder: (context, index) {
                                return Divider();
                              },
                              itemCount: data.length),
                        );
                      },
                      error: (error, stackTrace) {
                        return Text("Error");
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                    ElevatedButton(
                      child: const Text('Close BottomSheet'),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Future<Object> checkIfUserHasApp(String contact_person_number) async {
    final user = UserService.instance;
    final results = await user.getAllMembers();
    for (var i = 0; i < results.length; i++) {
      if (results[i]['phoneNumber'].replaceAll(' ', '') ==
          contact_person_number.replaceAll(' ', '')) {
        return {'hasApp': true, 'user': results[i]};
      } else {
        return {'hasApp': false};
      }
    }
    return {'hasApp': false};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () async {
                    final userService = UserService.instance;
                    final PermissionStatus permissionStatus =
                        await _getContactPermission();
                    if (permissionStatus == PermissionStatus.granted) {
                      //We can now access our contacts here
                      final list = await userService.getContactList();
                      displayContacts();
                    } else {
                      print("Nope");
                    }
                  },
                  child: Icon(Icons.add),
                )),
          ],
          title: Text(widget._pages[_selectedPageIndex]['title'] as String),
          automaticallyImplyLeading: false,
        ),
        body: widget._pages[_selectedPageIndex]['page'] as Widget,
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(),
          child: BottomNavigationBar(
            onTap: _selectPage,
            // backgroundColor: Colors.white,
            selectedItemColor: Colors.green,
            currentIndex: _selectedPageIndex,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_pin), label: 'Profile'),
            ],
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
