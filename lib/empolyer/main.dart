import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hayaah_karimuh/empolyer/helpers/firebase_helper.dart';
import 'package:hayaah_karimuh/empolyer/helpers/preferences_manager.dart';
import 'package:hayaah_karimuh/empolyer/screens/chat_view.dart';
import 'package:hayaah_karimuh/empolyer/utils/notification_service.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("Handling a background message: ${message.messageId}");
  log('Background Message: ${message.data}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PreferencesManager.init();
  await FirebaseHelper.init();
  await NotificationService().init();
  await FlutterDownloader.initialize(debug: true);
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );
  await initializeDateFormatting('ar');
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  );
  final navigatorKey = GlobalKey<NavigatorState>();
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    log('Got a message whilst in the foreground!');
    log('Message data: ${message.data}');

    if (message.notification != null) {
      log('Message also contained a notification: ${message.notification.toString()}');
    }
    NotificationService().showNotifications(message.data.hashCode, message.notification!.title!, message.notification!.body!, message.data.toString());
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    if (message.data['type'] == 'private') {
      navigatorKey.currentState!.push(MaterialPageRoute(
          builder: (_) => const ChatScreen(),
          settings: RouteSettings(arguments: {
            'group_id': message.data['group_id'],
            'type': 0,
            'is_notification': true,
            'new_chat': false,
          })));
    } else {
      navigatorKey.currentState!.push(MaterialPageRoute(
          builder: (_) => const ChatScreen(),
          settings: RouteSettings(arguments: {
            'group_id': message.data['group_id'],
            'type': 1,
            'is_notification': true,
            'new_chat': false,
          })));
    }
  });
}
