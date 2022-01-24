import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:saloon_app/models/user.dart';
import 'package:contacts_service/contacts_service.dart';

class UserService with ChangeNotifier {
  UserService._();
  static final instance = UserService._();

  bool? showPic;
  Future<User> getChats() async {
    final url = "https://randomuser.me/api/?results=10";
    final response = await Dio().get(url);
    var users = User.fromJson(response.data);
    return Future.value(users);
  }

  Future<List<Contact>> getContactList() async {
    List<Contact> contacts =
        await ContactsService.getContacts(withThumbnails: false);
    return contacts;
  }

  getMe(String? uid) async {
    var me = FirebaseFirestore.instance.collection('users').doc('$uid').get();
    return me;
  }

  getPictureStatus(String? uid) async {
    bool picStatus;
    var status = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      picStatus = value.data()?['showProfilePicture'];
      showPic = picStatus;
      return picStatus;
    });
    return status;
  }

  updatePictureStatus(String? uid, bool dec) {
    Map<String, bool> updt = {'showProfilePicture': dec};
    var status = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'showProfilePicture': dec}).then((value) {
      showPic = dec;
      notifyListeners();
    });
  }

  //Future<> updateMe(String ui) async {
  // final updatedMe = FireBase.Firestore.instance.collection(users).set('username', 'okihnjo')
  // return updatedMe
  //}
}
