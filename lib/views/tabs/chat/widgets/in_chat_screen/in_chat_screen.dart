// import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saloon_app/providers/messages_provider.dart';
import 'package:saloon_app/views/tabs/chat/widgets/in_chat_screen/widgets/input_bar.dart';
import 'package:saloon_app/views/tabs/chat/widgets/in_chat_screen/widgets/messages.dart';

class InChatScreen extends ConsumerWidget {
  const InChatScreen({Key? key}) : super(key: key);
  // final Object partner;

  @override
  Widget build(BuildContext context, ref) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map?;
    final user = routeArgs?['user'];
    final currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
        appBar: AppBar(
          title: Row(
            // mainAxisSize: MainAxisSize.min,
            children: [
              // ChatAvatar(picture: args.picture),
              const SizedBox(width: 15),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user['username'], overflow: TextOverflow.clip),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_sharp, size: 16),
                        const Icon(Icons.check_sharp, size: 16),
                        const SizedBox(width: 5),
                        Flexible(
                          child: const Text(
                            'Available',
                            style: const TextStyle(fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.phone,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.videocam),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Messages(
                  uid: currentUser?.uid,
                  user: user,
                ),
              ),
              InputBar(
                uid: currentUser?.uid,
                user: user,
              )
            ],
          ),
        ));
  }
}
