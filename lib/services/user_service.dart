import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:saloon_app/models/user.dart';

class UserService with ChangeNotifier {
  UserService._();
  static final instance = UserService._();

  Future<User> getChats() async {
    final url = "https://randomuser.me/api/?results=10";
    final response = await Dio().get(url);
    var users = User.fromJson(response.data);
    return Future.value(users);
  }
}
