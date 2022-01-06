// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saloon_app/providers/messages_provider.dart';

class InChatScreen extends ConsumerWidget {
  const InChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final stream = ref.watch(getMessagesProvider);
    return Scaffold(
        appBar: AppBar(),
        body: stream.when(
            data: (value) {
              // print(value.data.docments);
              return ListView.builder(
                  itemCount: value.docs.length,
                  itemBuilder: (ctx, index) => Container(
                        child: Text(value.docs[index]['text']),
                      ));
            },
            error: (e, stack) => Text('error'),
            loading: () => CircularProgressIndicator()));
  }
}
