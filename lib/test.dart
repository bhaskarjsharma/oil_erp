/*
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'main.dart';


class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late final InAppWebViewController webViewController;
  String url = "";
  double progress = 0;
  bool isLoading = false;
  bool _notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    _isAndroidPermissionGranted();
    _requestPermissions();
  }

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.areNotificationsEnabled() ??
          false;

      setState(() {
        _notificationsEnabled = granted;
      });
    }
  }
  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      final bool? grantedNotificationPermission =
      await androidImplementation?.requestNotificationsPermission();
      setState(() {
        _notificationsEnabled = grantedNotificationPermission ?? false;
      });
    }
  }

  Future<void> _requestPermissionsWithCriticalAlert() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
        critical: true,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
        critical: true,
      );
    }
  }

  Future<void> _requestNotificationPolicyAccess() async {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await androidImplementation?.requestNotificationPolicyAccess();
  }
  Future<void> _requestFullScreenIntentPermission() async {
    final bool permissionGranted = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestFullScreenIntentPermission() ??
        false;
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: Text(
              'Full screen intent permission granted: $permissionGranted'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ));
  }


  @override
  void dispose() {
    selectNotificationStream.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE5E5E5),
        title: Text(
          'OIL ERP Mobile',
          style:  TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Text color
            letterSpacing: 1.2,  // Optional: spacing between letters
          ),
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await _requestPermissions();
            },
            child: Text('Request permission (API 33+)'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _requestNotificationPolicyAccess();
            },
            child: Text('Request notification policy access'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _requestFullScreenIntentPermission();
            },
            child: Text('Request full-screen intent permission (API 34+)'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _showNotification();
            },
            child: Text('Show plain notification with payload'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _showNotificationCustomSound();
            },
            child: Text('Show notification with custom sound'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _showFullScreenNotification();
            },
            child: Text('Show full-screen notification'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _showNotificationWithAudioAttributeAlarm();
            },
            child: Text('Show notification with sound controlled by '
                'alarm volume'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _showNotificationWithDndBypass();
            },
            child: Text('Show notification that ignores dnd'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _showNotificationWithCriticalSound();
            },
            child: Text('Show notification with critical sound'),
          ),
        ],
      ),
    );
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        id++, 'plain title', 'plain body', notificationDetails,
        payload: 'item x');
  }

  Future<void> _showFullScreenNotification() async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Turn off your screen'),
        content: const Text(
            'to see the full-screen intent in 5 seconds, press OK and TURN '
                'OFF your screen. Note that the full-screen intent permission must '
                'be granted for this to work too'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await flutterLocalNotificationsPlugin.zonedSchedule(
                  0,
                  'scheduled title',
                  'scheduled body',
                  tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
                  const NotificationDetails(
                      android: AndroidNotificationDetails(
                          'full screen channel id', 'full screen channel name',
                          channelDescription: 'full screen channel description',
                          priority: Priority.high,
                          importance: Importance.high,
                          fullScreenIntent: true)),
                  androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);

              Navigator.pop(context);
            },
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  Future<void> _showNotificationCustomSound() async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'your other channel id',
      'your other channel name',
      channelDescription: 'your other channel description',
      sound: RawResourceAndroidNotificationSound('sos'),
    );
    const DarwinNotificationDetails darwinNotificationDetails =
    DarwinNotificationDetails(
      sound: 'sos.mp3',
    );
    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      id++,
      'custom sound notification title',
      'custom sound notification body',
      notificationDetails,
    );
  }

  Future<void> _showNotificationWithDndBypass() async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel id 3', 'your channel name 3',
        channelDescription: 'your channel description 3',
        channelBypassDnd: true,
        importance: Importance.max);
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      id++,
      'I ignored dnd',
      'I completely ignored dnd',
      notificationDetails,
    );
  }

  Future<void> _createNotificationChannelWithDndBypass() async {
    const AndroidNotificationChannel androidNotificationChannel =
    AndroidNotificationChannel('your channel id 3', 'your channel name 3',
        description: 'your channel description 3',
        bypassDnd: true,
        importance: Importance.max);

    final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    final bool? hasPolicyAccess =
    await androidPlugin?.hasNotificationPolicyAccess();
    if (hasPolicyAccess ?? false) {
      await androidPlugin?.requestNotificationPolicyAccess();
    }

    await androidPlugin?.createNotificationChannel(androidNotificationChannel);

    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(
            'Channel with name ${androidNotificationChannel.name} created'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  Future<void> _showNotificationWithCriticalSound() async {
    const DarwinNotificationDetails darwinNotificationDetails =
    DarwinNotificationDetails(
      // Between 0.0 and 1.0
      criticalSoundVolume: 1.0,
      // If sound is not specified, the default sound will be used
      sound: 'slow_spring_board.aiff',
    );
    const NotificationDetails notificationDetails = NotificationDetails(
      iOS: darwinNotificationDetails,
      macOS: darwinNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      id++,
      'Critical sound notification title',
      'Critical sound notification body',
      notificationDetails,
    );
  }

  Future<void> _showNotificationWithAudioAttributeAlarm() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your alarm channel id',
      'your alarm channel name',
      channelDescription: 'your alarm channel description',
      importance: Importance.max,
      priority: Priority.high,
      audioAttributesUsage: AudioAttributesUsage.alarm,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'notification sound controlled by alarm volume',
      'alarm notification sound body',
      platformChannelSpecifics,
    );
  }

}
*/
