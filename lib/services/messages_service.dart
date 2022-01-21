import 'package:cloud_firestore/cloud_firestore.dart';

class MessageService {
  MessageService._();
  static final instance = MessageService._();

  Stream getMessages() {
    var something = FirebaseFirestore.instance
        .collection('chats/4L9W8OIBX3s35jMfCo1z/messages')
        .snapshots();
    return something;
  }

  Stream getMessagesForSingleChat() {
    var chats_future = FirebaseFirestore.instance
        .collection('chat')
        .orderBy('createdAt', descending: true)
        .snapshots();
    return chats_future;
  }

  // getChats() {
  // final chats = http.get(uri/chats, header: token)}
}
