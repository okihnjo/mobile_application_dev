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
