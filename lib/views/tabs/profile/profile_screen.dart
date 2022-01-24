import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saloon_app/providers/user_provider.dart';

class ProfileScreen extends ConsumerWidget {
  ProfileScreen({Key? key}) : super(key: key);
  static const String pageName = "ProfileScreen";
  @override
  Widget build(BuildContext context, ref) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final meProvider = ref.watch(getMeFutureProvider(currentUser?.uid));
    return meProvider.when(
        data: (data) => Container(
                child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Stack(
                        children :[ ClipOval(
                            child: Material(
                                child: Ink.image(
                          image: NetworkImage(
                              data.data()["profilePicture"].toString()),
                          height: 128,
                          width: 128,
                          fit: BoxFit.cover,
                          child: InkWell(
                            onTap: () {},
                          ),
                        ))),buildEditIcon()], 
                        ),
                      SizedBox(width: 15),
                      Column(
                        children: [
                          Text(data.data()["name"] + " " + data.data()["surname"],
                          style: TextStyle(fontSize: 25) ,),
                          Text(
                            data.data()["status"],
                            style: TextStyle(color: Colors.grey, fontSize: 20),
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
                        leading: Icon(Icons.payment),
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
                        leading: Icon(Icons.mail),
                        title: Text("Mail"),
                      )))
                    ],
                  ))
                ],
              ),
            )),
        loading: () {
          return Center(child: CircularProgressIndicator());
        },
        error: (Object error, StackTrace? stackTrace) {
          return Text("Error");
        });
  }
  Widget buildEditIcon () => Icon(
    Icons.edit,
    size: 15,


  );
}
