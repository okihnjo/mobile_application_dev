import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saloon_app/providers/user_provider.dart';

class UserDetailsScreen extends ConsumerWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);
  static const String routeName = "/userDetailsScreen";
  @override
  Widget build(BuildContext context, ref) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map?;
    final user = routeArgs?['user'];
    final meProvider = ref.watch(getMeFutureProvider(user['userId']));
    return meProvider.when(
        data: (data) => Scaffold(
              appBar: AppBar(),
              body: Container(
                  child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            ClipOval(
                                child: (data.data()['showProfilePicture'] &&
                                        data
                                                .data()['profilePicture']
                                                .toString()
                                                .length >
                                            3)
                                    ? Material(
                                        child: Ink.image(
                                        image: NetworkImage(data
                                            .data()["profilePicture"]
                                            .toString()),
                                        height: 128,
                                        width: 128,
                                        fit: BoxFit.cover,
                                        child: InkWell(
                                          onTap: () {},
                                        ),
                                      ))
                                    : const Text(
                                        'N/A ',
                                        style: TextStyle(fontSize: 15),
                                      )),
                          ],
                        ),
                        SizedBox(width: 15),
                        Column(
                          children: [
                            Text(
                              data.data()["name"] +
                                  " " +
                                  data.data()["surname"],
                              style: TextStyle(fontSize: 25),
                            ),
                            Text(
                              data.data()["status"],
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Flexible(
                        child: Column(
                      children: [
                        Expanded(
                            child: Card(
                                child: ListTile(
                          leading: Icon(Icons.mail),
                          title: Text(data.data()["email"]),
                        ))),
                        Expanded(
                            child: Card(
                                child: ListTile(
                          leading: Icon(Icons.person),
                          title: Text(data.data()["name"]),
                        ))),
                        Expanded(
                            child: Card(
                                child: ListTile(
                          leading: Icon(Icons.people_alt),
                          title: Text(data.data()["surname"]),
                        ))),
                        Expanded(
                            child: Card(
                                child: ListTile(
                          leading: Icon(Icons.phone),
                          title: Text(data.data()["phoneNumber"].toString()),
                        ))),
                        Expanded(
                            child: Card(
                                child: ListTile(
                          leading: Icon(Icons.person_pin),
                          title: Text(
                            data.data()["username"],
                          ),
                        )))
                      ],
                    ))
                  ],
                ),
              )),
            ),
        loading: () {
          return Center(child: CircularProgressIndicator());
        },
        error: (Object error, StackTrace? stackTrace) {
          return Text("Error");
        });
  }

  Widget buildEditIcon() => Icon(
        Icons.edit,
        size: 15,
      );
}
