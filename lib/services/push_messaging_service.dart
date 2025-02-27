import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushMessagingService {
  final FirebaseMessaging fcm;
  final FlutterLocalNotificationsPlugin localNotificationsPlugin;
  final NotificationDetails localNotificationDetails;
  final BackgroundMessageHandler backgroundHandler;

  StreamController<RemoteMessage> controller =
      StreamController<RemoteMessage>.broadcast();

  PushMessagingService({
    required this.fcm,
    required this.localNotificationsPlugin,
    required this.localNotificationDetails,
    required this.backgroundHandler,
  });

  Future init() async {
    await fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      announcement: true,
      carPlay: true,
    );

    if (Platform.isIOS) {
      await fcm.setForegroundNotificationPresentationOptions(
          sound: true, badge: true, alert: true);
    }

    // init local notifications
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = DarwinInitializationSettings(
      defaultPresentSound: true,
      defaultPresentBadge: true,
      defaultPresentAlert: true,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await localNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.instance
        .getToken()
        .then((token) => print('getToken $token'));

    // FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        localNotificationsPlugin.show(
          0,
          message.notification!.title,
          message.notification!.body,
          localNotificationDetails,
        );
      }
      controller.add(message);
    });

    fcm.onTokenRefresh.listen((event) {
      print('onTokenRefresh $event');
    });
  }
}
