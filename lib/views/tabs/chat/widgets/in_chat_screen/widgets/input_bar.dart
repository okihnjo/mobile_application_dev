import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saloon_app/providers/user_provider.dart';

class InputBar extends ConsumerStatefulWidget {
  const InputBar({Key? key, this.uid, this.user}) : super(key: key);

  final String? uid;
  final user;

  @override
  _InputBarState createState() => _InputBarState();
}

class _InputBarState extends ConsumerState<InputBar> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';

  void _sendMessage(data) {
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance // my collection
        .collection('users')
        .doc(widget.uid)
        .collection('chats')
        .doc(widget.user['userId'])
        .collection('messages')
        .add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': widget.user['userId'],
      'received': false,
      'username': widget.user['username']
    });
    FirebaseFirestore.instance // my collection
        .collection('users')
        .doc(widget.uid)
        .collection('chats')
        .doc(widget.user['userId'])
        .set({
      'userId': widget.user['userId'],
      'username': widget.user['username'],
      'received': false,
      'createdAt': Timestamp.now(),
      'lastMessage': _enteredMessage
    });
    FirebaseFirestore.instance // his/her collection
        .collection('users')
        .doc(widget.user['userId'])
        .collection('chats')
        .doc(widget.uid)
        .collection('messages')
        .add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': widget.uid, // nicht meine
      'received': true,
      'username': data['username']
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user['userId'])
        .collection('chats')
        .doc(widget.uid)
        .set({
      'userId': widget.uid,
      'username': data['username'],
      'received': true,
      'createdAt': Timestamp.now(),
      'lastMessage': _enteredMessage
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final me = ref.watch(getMeFutureProvider(widget.uid));
    return me.when(
        data: (data) => Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  const IconButton(
                      icon: Icon(Icons.attach_file), onPressed: null),
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 5,
                            color: Colors.grey)
                      ],
                    ),
                    child: Row(children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration:
                              InputDecoration(labelText: "Send a message..."),
                          onChanged: (value) {
                            setState(() {
                              _enteredMessage = value;
                            });
                          },
                        ),
                      ),
                      IconButton(icon: Icon(Icons.face), onPressed: () {}),
                    ]),
                  )),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                    child: IconButton(
                        color: Colors.white,
                        onPressed: _enteredMessage.trim().isEmpty
                            ? null
                            : () => _sendMessage(data.data()),
                        icon: Icon(Icons.send)),
                  )
                ],
              ),
            ),
        error: (error, stack) => Text("Error"),
        loading: () => Center(
              child: CircularProgressIndicator(),
            ));
  }
}
