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
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map;
    final user = routeArgs['user'];
    final currentUser = FirebaseAuth.instance.currentUser;
    final stream = ref.watch(getMessagesProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(user['username']),
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Messages(
                  uid: currentUser?.uid,
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
