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
                      ClipOval(
                          child: Material(
                              child: Ink.image(
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHJhbmRvbSUyMHBlb3BsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60"),
                        height: 128,
                        width: 128,
                        child: InkWell(
                          onTap: () {},
                        ),
                      ))),
                      SizedBox(width: 15),
                      Column(
                        children: [
                          Text("Eve"),
                          Text(
                            "Fashion Model",
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
                        leading: Icon(Icons.favorite),
                        title: Text("Your Favorites"),
                      ))),
                      Expanded(
                          child: Card(
                              child: ListTile(
                        leading: Icon(Icons.payment),
                        title: Text("Payment"),
                      ))),
                      Expanded(
                          child: Card(
                              child: ListTile(
                        leading: Icon(Icons.people_alt),
                        title: Text("Tell Your Friend"),
                      ))),
                      Expanded(
                          child: Card(
                              child: ListTile(
                        leading: Icon(Icons.label_important),
                        title: Text("Promotions"),
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
}
