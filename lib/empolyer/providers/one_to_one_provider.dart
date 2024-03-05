import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hayaah_karimuh/empolyer/helpers/firebase_helper.dart';
import 'package:hayaah_karimuh/empolyer/models/chat_group.dart';

class OneToOneProvider extends ChangeNotifier {
  bool _groupsLoaded = false;
  List<ChatGroup> _groups = [];

  List<ChatGroup> get groups {
    return _groups;
  }

  Future<void> load({required int memberId, required bool refresh}) async {
    log('OneToOne Refresh');
    if (!_groupsLoaded) {
      EasyLoading.show();
      _groups = await FirebaseHelper().getPrivateChats(memberId: memberId);
      EasyLoading.dismiss();
      _groupsLoaded = true;
      notifyListeners();
    } else {
      if (refresh) {
        EasyLoading.show();
        _groups = await FirebaseHelper().getPrivateChats(memberId: memberId);
        EasyLoading.dismiss();
        _groupsLoaded = true;
        notifyListeners();
      }
    }
  }
}
