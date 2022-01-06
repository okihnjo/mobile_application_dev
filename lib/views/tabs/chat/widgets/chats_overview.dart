import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saloon_app/providers/user_provider.dart';
import 'package:saloon_app/views/tabs/chat/widgets/chat_tile/chat_tile.dart';

class ChatsOverview extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final chatsProvider = ref.watch(getChatsFutureProvider);
    return chatsProvider.when(
        data: (data) {
          return Expanded(
              child: ListView.separated(
            itemCount: data.results.length,
            itemBuilder: (ctx, i) => ChatTile(
              name: (data.results[i].name?.first as String) +
                  ' ' +
                  (data.results[i].name?.last as String),
              pictureUrl: data.results[i].picture?.medium,
            ),
            separatorBuilder: (context, index) {
              return Divider();
            },
          ));
        },
        loading: () => CircularProgressIndicator(),
        error: (_, __) {
          return const Text('Ein Fehler beim Laden der Chats');
        });
  }
}
