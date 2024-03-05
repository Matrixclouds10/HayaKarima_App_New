import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../helpers/firebase_helper.dart';

class GroupFilesProvider extends ChangeNotifier {
  Future<QuerySnapshot> getGroupMessages({required String groupId}) {
    EasyLoading.show();
    final future = FirebaseHelper().getGroupMessagesOnce(groupId: groupId);
    EasyLoading.dismiss();
    return future;
  }
}
