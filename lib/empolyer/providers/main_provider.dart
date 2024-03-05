import 'package:flutter/material.dart';
import 'package:hayaah_karimuh/empolyer/models/responses/notification_count_response.dart';

import '../data/network_repo.dart';
import '../helpers/preferences_manager.dart';
import '../models/responses/api_response.dart';

class MainProvider extends ChangeNotifier {
  int notificationCount = 0;
  bool loaded = false;

  Future<void> getNotificationsCount() async {
    if (!loaded) {
      ApiResponse apiResponse = await NetworkRepo().getNotificationsCount();
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        NotificationCountResponse notificationCountResponse = NotificationCountResponse.fromJson(apiResponse.response!.data);
        notificationCount = notificationCountResponse.items!.unRead!;
        loaded = true;
      }
      notifyListeners();
    }
  }

  Future<bool> logout() async {
    ApiResponse apiResponse = await NetworkRepo().logout();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      await PreferencesManager.clearAppData();
      return true;
    } else {
      return false;
    }
  }
}
