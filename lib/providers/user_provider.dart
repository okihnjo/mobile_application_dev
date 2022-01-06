import 'package:riverpod/riverpod.dart';
import 'package:saloon_app/services/user_service.dart';

final getChatsFutureProvider = FutureProvider.autoDispose((ref) async {
  // ref.maintainState = true;
  final getChatsService = UserService.instance;
  return await getChatsService.getChats();
});
