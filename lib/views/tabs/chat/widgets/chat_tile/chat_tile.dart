import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saloon_app/providers/user_provider.dart';
import 'package:saloon_app/views/tabs/chat/widgets/chat_tile/widgets/chat_avatar.dart';
import 'package:saloon_app/views/tabs/chat/widgets/chat_tile/widgets/chat_trailing_info.dart';

/// The chattiles when user clicks on the chatTabs. They get rendered depending on
/// how many chats/users there are.
/// Expects a name and a picture which get displayed in the OverviewScreen.
class ChatTile extends StatelessWidget {
  final name;
  final pictureUrl;
  final user;

  ChatTile({this.name, this.pictureUrl, this.user});
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: ChatAvatar(
          picture: this.pictureUrl,
        ),
        trailing: ChatTrailingInfo(),
        title: Text(name),
        onTap: () => Navigator.of(context)
            .pushNamed('/chat', arguments: {'user': user}));
  }
}

class ScreenArguments {
  final String name;
  final String picture;

  ScreenArguments(this.name, this.picture);
}
