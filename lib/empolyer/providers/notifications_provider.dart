import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hayaah_karimuh/empolyer/models/responses/user_notifications_response.dart';
import 'package:hayaah_karimuh/empolyer/models/user_notification.dart';

import '../data/network_repo.dart';
import '../models/responses/api_response.dart';

class NotificationsProvider extends ChangeNotifier {
  List<UserNotification> notifications = [];
  int? totalPages;

  Future<void> getUserNotifications() async {
    EasyLoading.show();
    ApiResponse apiResponse = await NetworkRepo().getUserNotifications();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      UserNotificationsResponse userNotificationsResponse = UserNotificationsResponse.fromJson(apiResponse.response!.data);
      notifications.clear();
      notifications.addAll(userNotificationsResponse.items!);
    }
    EasyLoading.dismiss();
    notifyListeners();
  }

  Future readNotification(int notificationId) async {
    await NetworkRepo().readNotification(notificationId: notificationId);
    await getUserNotifications();
  }
}
