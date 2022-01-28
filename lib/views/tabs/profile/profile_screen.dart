import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saloon_app/providers/user_provider.dart';
import 'package:saloon_app/views/tab_containter.dart';
import 'package:saloon_app/views/tabs/profile/upload_image.dart';

class ProfileScreen extends ConsumerWidget {
  ProfileScreen({Key? key}) : super(key: key);
  static const String pageName = "ProfileScreen";
  @override
  Widget build(BuildContext context, ref) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final meProvider = ref.watch(getMeFutureProvider(currentUser?.uid));
    return meProvider.when(
        data: (data) => RefreshIndicator(
          onRefresh: () {print("ich bin refresher");
         ref.refresh(getMeFutureProvider(currentUser?.uid));
         return ref.read(getMeFutureProvider(currentUser?.uid).future);},
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                    child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              ClipOval(
                                  child: Material(
                                      child: Ink.image(
                                image: NetworkImage(
                                    data.data()["profilePicture"].toString()),
                                height: 128,
                                width: 128,
                                fit: BoxFit.cover,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SecondRoute(
                                                data
                                                    .data()["profilePicture"]
                                                    .toString(),
                                                data.data()["email"],
                                                data.data()["name"],
                                                data.data()["surname"],
                                                data
                                                    .data()["phoneNumber"]
                                                    .toString(),
                                                data.data()["status"], data.data()["username"])));
                                  },
                                ),
                              ))),
                              Positioned(
                                  bottom: 0, right: 4, child: buildEditIcon())
                            ],
                          ),
                          SizedBox(width: 15),
                          Column(
                            children: [
                              Text(
                                data.data()["name"] + " " + data.data()["surname"],
                                style: TextStyle(fontSize: 25),
                              ),
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
                            title: Text(data.data()["username"]),
                          )))
                        ],
                      ))
                    ],
                  ),
                )),
          ),
        ),
        loading: () {
          return Center(child: CircularProgressIndicator());
        },
        error: (Object error, StackTrace? stackTrace) {
          return Text("Error");
        });
  }

  Widget buildEditIcon() => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          child: Icon(
            Icons.edit,
            size: 21,
            color: Colors.white,
          ),
          color: Colors.blue,
          all: 8,
        ),
      );
  Widget buildCircle(
          {required Widget child, required Color color, required double all}) =>
      ClipOval(
        child: Container(
          color: color,
          padding: EdgeInsets.all(all),
          child: child,
        ),
      );
}

class SecondRoute extends StatefulWidget {
  String profilePicture;
  String mail;
  String name;
  String surname;
  String phoneNumber;
  String status;
  String username;
  SecondRoute(
    @required this.profilePicture,
    @required this.mail,
    @required this.name,
    @required this.surname,
    @required this.phoneNumber,
    @required this.status, @required this.username, {
    Key? key,
  }) : super(key: key);

  @override
  State<SecondRoute> createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  late File _userImageFile;
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController statusController = new TextEditingController();

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 650,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              ImagePickerr(widget.profilePicture, _pickedImage)
                            ],
                          ),
                          SizedBox(width: 15),
                          Column(
                            children: [
                              Text(
                                widget.name + " " + widget.surname,
                                style: TextStyle(fontSize: 25),
                              ),
                              Container(
                                  width: 220,
                                  padding: EdgeInsets.all(5.0),
                                  child: TextField(
                                    controller: statusController
                                      ..text = widget.status,
                                      onChanged: (value) => {widget.status = value as String},
                                    decoration: InputDecoration(
                                      //hintText: widget.status,
                                      hintStyle: TextStyle(color: Colors.black),
                                      filled: true,
                                      fillColor: Colors.white70,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.0)),
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 2),
                                      ),
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Flexible(
                          child: Form(
                        key: _key,
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                child: TextFormField(
                                  initialValue: widget.mail,
                                  onSaved: (value) {
                                    widget.mail = value as String;
                                  },
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !value.contains('@')) {
                                      return "Please enter a valid email address";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      labelText: "Email address"),
                                )),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                child: TextFormField(
                                  initialValue: widget.name,
                                  onSaved: (value) {
                                    widget.name = value as String;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter a valid name";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration:
                                      InputDecoration(labelText: "Name"),
                                )),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                child: TextFormField(
                                  initialValue: widget.surname,
                                  onSaved: (value) {
                                    widget.surname = value as String;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter a valid surname";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration:
                                      InputDecoration(labelText: "Surname"),
                                )),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                child: TextFormField(
                                  initialValue: widget.phoneNumber,
                                  onSaved: (value) {
                                    widget.phoneNumber = value as String;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter a valid phonenumber";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.phone,
                                  decoration:
                                      InputDecoration(labelText: "Phonenumber"),
                                )),
                                Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                child: TextFormField(
                                  initialValue: widget.username,
                                  onSaved: (value) {
                                    widget.username = value as String;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter a valid username";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration:
                                      InputDecoration(labelText: "Username"),
                                )),
                            ElevatedButton(
                              onPressed: () async {
                                final currentUser =
                                    FirebaseAuth.instance.currentUser;
                                final isValid = _key.currentState?.validate();
                                FocusScope.of(context).unfocus();
                                if (isValid == true) {
                                  _key.currentState?.save();
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(currentUser?.uid)
                                      .update({
                                    'email': widget.mail,
                                    'name': widget.name,
                                    'surname': widget.surname,
                                    'phoneNumber': widget.phoneNumber,
                                    'status': statusController.text,
                                    'username': widget.username
                                  });
                                  Navigator.of(context).pop();
                                }

                                print("update onpressed function");
                                print("mail: " + widget.mail);
                              },
                              child: Text("update"),
                            )
                          ],
                        ),
                      ))
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

Widget buildTextField(@required data) => (Container(
    width: 420,
    padding: EdgeInsets.all(10.0),
    child: TextField(
      decoration: InputDecoration(
        hintText: data,
        prefixIcon: Icon(Icons.mail),
        hintStyle: TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.white70,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    )));
