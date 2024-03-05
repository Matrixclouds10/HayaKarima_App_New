import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../data/network_repo.dart';
import '../helpers/firebase_helper.dart';
import '../models/group_member.dart';
import '../models/responses/api_response.dart';
import '../models/user.dart';

class AddGroupMembersProvider extends ChangeNotifier {
  bool _userLoaded = false;
  List<User> _users = [];

  List<User> get users => _users;

  Future<void> load() async {
    if (!_userLoaded) {
      EasyLoading.show();
      // notifyListeners();
      ApiResponse apiResponse = await NetworkRepo().getUsers();
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        apiResponse.response!.data
            .forEach((userData) => _users.add(User.fromJson(userData)));
      }
      log('User Count: ${_users.length}');
      for (var element in _users) {
        log('User Image: ${element.image}');
      }
      _userLoaded = true;
      EasyLoading.dismiss();
    }
    notifyListeners();
  }

  Future<void> addGroupMembers(
      String groupId, List<GroupMember> newMembers) async {
    return await FirebaseHelper().addGroupMembers(groupId, newMembers);
  }
}
