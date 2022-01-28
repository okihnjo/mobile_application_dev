import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:saloon_app/providers/user_provider.dart';
import 'package:saloon_app/views/tab_containter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ImagePickerr extends StatefulWidget {
  String profilePic;
  ImagePickerr(this.profilePic, this.imagePickFn, {Key? key}) : super(key: key);

  final void Function(File pickedImage) imagePickFn;

  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePickerr> {
  File? image;

  Future pickImage() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    print("profilePic: " + widget.profilePic);
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      widget.profilePic = imageTemporary.path;
    });
    widget.imagePickFn(imageTemporary);
    print("widget.profilepic: " + widget.profilePic);

    final ref = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child(currentUser!.uid + ".jpg");
    await ref.putFile(imageTemporary);
    final url = await ref.getDownloadURL();
    print("url: " + url);
    

    await FirebaseFirestore.instance.collection('users')
                                    .doc(currentUser.uid)
                                    .update({ 'profilePicture': url});

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children:[ ClipOval(
            child: Material(
                child: Ink.image(
      image: NetworkImage(widget.profilePic),
      height: 128,
      width: 128,
      fit: BoxFit.cover,
      child: InkWell(
        onTap: () {
          pickImage();
        },
      ),
    ))),
    Positioned( bottom: 0, right: 4, child: buildEditIcon())
                        ]
    ));
  }
}
Widget buildEditIcon() => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          child: Icon(
            Icons.add_a_photo,
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
