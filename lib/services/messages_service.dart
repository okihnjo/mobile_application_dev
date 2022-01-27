import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Stream getMessagesWithPartner(String? partnerUid) {
    final currentUser = FirebaseAuth.instance.currentUser;
    var messages = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser?.uid)
        .collection('chats')
        .doc(partnerUid)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots();
    return messages;
  }

  // getChats() {
  // final chats = http.get(uri/chats, header: token)}
}
