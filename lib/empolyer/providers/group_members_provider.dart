import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hayaah_karimuh/empolyer/helpers/firebase_helper.dart';

class GroupMembersProvider extends ChangeNotifier {
  bool canAddMembers = false;

  void setCanAddMembers(bool value) {
    canAddMembers = value;
    notifyListeners();
  }

  Future<void> deleteGroup(String groupId) {
    return FirebaseHelper().deleteGroup(groupId);
  }

  Future<void> leaveGroup(String groupId, int memberId) async {
    return await FirebaseHelper().leaveGroup(groupId, memberId);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getGroupMembers(String groupId) {
    return FirebaseHelper().getGroupStream(groupId);
  }

  Future<void> setMemberAdmin(String groupId, int userId) async {
    return FirebaseHelper().setUserAdmin(groupId, userId);
  }
}
