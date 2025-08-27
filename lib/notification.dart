import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'main.dart';

// Top level background notification handler
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  notificationService.showLocalNotification(message);
}

class NotificationService {

  String fcmToken = '';

  NotificationService() {
    // Initialize Firebase Messaging
    _initializeFCM();
    // Initialize Flutter Local Notifications
    _initializeFlutterLocalNotifications();
  }

  void _initializeFCM() async {
    messaging.setAutoInitEnabled(true);

    // Request permission
    //messaging.requestPermission(sound: true, badge: true, alert: true);
    fcmToken = await messaging.getToken() ?? '';
    debugPrint('FCM Token: $fcmToken');

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      showLocalNotification(message);
    });
  }

  void handlePendingNotifications() {
    // Handle initial notification when the app is started from a terminated state
    messaging.getInitialMessage().then((message) {
      if (message != null) {
        _handleNotificationTap(message);
      }
    });
  }

  void _handleNotificationTap(RemoteMessage message) {
    final data = message.data;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      router.push('/notification', extra: data);
    });
  }

  void _initializeFlutterLocalNotifications() {
    var initializationSettingsAndroid = const AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        final message = RemoteMessage.fromMap({'data': jsonDecode(details.payload ?? '{}')});
        _handleNotificationTap(message);
      },
    );

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

/*    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );*/
  }

  void showLocalNotification(RemoteMessage message) {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel_id',
      'Channel Name',
      channelDescription: 'Channel Description',
      sound: RawResourceAndroidNotificationSound('sos'),
      channelBypassDnd: true,
      importance: Importance.max,
      priority: Priority.max,
      fullScreenIntent: true,
      audioAttributesUsage: AudioAttributesUsage.alarm,

    );
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(sound: 'sos.mp3',
      criticalSoundVolume: 1.0,);
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    // Define the ID of the notification
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    flutterLocalNotificationsPlugin.show(
      id,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      platformChannelSpecifics,
      payload: jsonEncode(message.data),
    );
  }
}

NotificationService notificationService = NotificationService();



