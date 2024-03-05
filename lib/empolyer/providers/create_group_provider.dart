import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hayaah_karimuh/empolyer/data/network_repo.dart';
import 'package:hayaah_karimuh/empolyer/helpers/firebase_helper.dart';
import 'package:hayaah_karimuh/empolyer/models/chat_group.dart';
import 'package:hayaah_karimuh/empolyer/models/responses/api_response.dart';
import 'package:hayaah_karimuh/empolyer/models/user.dart';

class CreateGroupProvider extends ChangeNotifier {
  bool _userLoaded = false;
  final List<User> _users = [];
  List<String> govs = [];
  List<String> selectedGovs = [];

  void toggleSelectedGov(String gov) {
    if (!selectedGovs.contains(gov)) {
      selectedGovs.add(gov);
    } else {
      selectedGovs.remove(gov);
    }
    notifyListeners();
  }

  List<User> get users {
    return _users;
  }

  Future<void> load() async {
    if (!_userLoaded) {
      EasyLoading.show();
      // notifyListeners();
      ApiResponse apiResponse = await NetworkRepo().getUsers();
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        apiResponse.response!.data.forEach((userData) => _users.add(User.fromJson(userData)));
      }
      log('User Count: ${_users.length}');
      for (var element in _users) {
        log('User Image: ${element.image}');
        if (!govs.contains(element.governorate)) {
          govs.add(element.governorate!);
        }
      }
      _userLoaded = true;
      EasyLoading.dismiss();
    }
    notifyListeners();
  }

  Future<String> createGroup(ChatGroup chatGroup) async {
    return await FirebaseHelper().addGroup(chatGroup);
  }

  Future<String> createPrivateChat(ChatGroup chatGroup) async {
    return await FirebaseHelper().addPrivate(chatGroup);
  }

  Future<String> uploadGroupImage(String filePath, int userId) async {
    return await FirebaseHelper().uploadGroupImage(filePath, userId);
  }
}
