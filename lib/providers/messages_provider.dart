import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';
import 'package:saloon_app/services/messages_service.dart';

final getMessagesProvider =
    StreamProvider.autoDispose((ref) => MessageService.instance.getMessages());

final getSingleMessageProvider = StreamProvider.autoDispose(
    (ref) => MessageService.instance.getMessagesForSingleChat());

final getSingleMessageProvider_2 = StreamProvider.autoDispose.family(
    (ref, String? partnerUid) =>
        MessageService.instance.getMessagesWithPartner(partnerUid));
