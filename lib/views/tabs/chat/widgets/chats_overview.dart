import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saloon_app/providers/user_provider.dart';
import 'package:saloon_app/views/tabs/chat/widgets/chat_tile/chat_tile.dart';

class ChatsOverview extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final currentUser = FirebaseAuth.instance.currentUser;
    // final chatsProvider = ref.watch(getChatsFutureProvider);
    final stream = ref.watch(getChatsStreamProvider(currentUser?.uid));
    return stream.when(
        data: (value) {
          print(value);
          return value.docs.length == 0
              ? Text("No chats")
              : Expanded(
                  child: ListView.separated(
                  itemCount: value.docs.length,
                  itemBuilder: (ctx, i) => ChatTile(
                    user: value.docs[i].data(),
                    name: value.docs[i].data()['username'],
                    pictureUrl: '',
                  ),
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                ));
        },
        error: (error, stackTrace) => const Center(
              child: Text("Fehler"),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
