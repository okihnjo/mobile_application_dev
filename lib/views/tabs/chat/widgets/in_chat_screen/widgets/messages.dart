import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saloon_app/providers/messages_provider.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

class Messages extends ConsumerWidget {
  const Messages({Key? key, this.uid, this.user}) : super(key: key);

  final String? uid;
  final user;
  @override
  Widget build(BuildContext context, ref) {
    // final stream = ref.watch(getSingleMessageProvider);
    final message_stream =
        ref.watch(getSingleMessageProvider_2(user['userId']));
    return message_stream.when(
      data: (value) => ListView.builder(
          reverse: true,
          itemCount: value.docs.length,
          itemBuilder: (ctx, index) => Container(
                child: BubbleNormal(
                  text: value.docs[index]['text'],
                  isSender: !value.docs[index]['received'],
                  color: value.docs[index]['received']
                      ? Colors.blue
                      : Colors.green,
                  tail: true,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              )),
      error: (error, stackTrace) => const Center(
        child: Text("Fehler"),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
