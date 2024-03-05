import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channelId = '123';

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    // tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        log('notification payload: $payload');
      }
    });
  }

  final AndroidNotificationDetails _androidNotificationDetails =
      const AndroidNotificationDetails(channelId, 'Hayah Karima',
          channelDescription: 'Channel Description',
          playSound: true,
          priority: Priority.high,
          importance: Importance.high,
          visibility: NotificationVisibility.public);

  Future<void> showNotifications(
      int id, String title, String body, String payload) async {
    await flutterLocalNotificationsPlugin.show(id, title, body,
        NotificationDetails(android: _androidNotificationDetails),
        payload: payload);
  }

  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

// void selectNotification(String payload) async {
//   print('Payload: $payload');
//   // Get.to(
//   //     VedioView(
//   //       payload,
//   //     ),
//   //     fullscreenDialog: true);
// }
