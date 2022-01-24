import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:saloon_app/services/user_service.dart';

final getChatsFutureProvider = FutureProvider.autoDispose((ref) async {
  // ref.maintainState = true;
  final getChatsService = UserService.instance;
  return await getChatsService.getChats();
});

final getContactsProvider = FutureProvider((ref) async {
  final userService = UserService.instance;
  return await userService.getContactList();
});

final getMeFutureProvider = FutureProvider.family((ref, String? uid) async {
  final getMeService = UserService.instance;
  return await getMeService.getMe(uid);
});

final getPictureStatusProvider =
    FutureProvider.family((ref, String? uid) async {
  final getPictureStatus = UserService.instance;
  return await getPictureStatus.getPictureStatus(uid);
});

final userProvider = ChangeNotifierProvider((ref) {
  return UserService.instance; // why is using autoDispose crashing the app?
});
