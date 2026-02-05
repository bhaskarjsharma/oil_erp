

import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import 'main.dart';
import 'notification.dart';

class SOS extends StatefulWidget {
  const SOS({super.key});

  @override
  State<SOS> createState() => _SOSState();
}

class _SOSState extends State<SOS> {

  bool _notificationsEnabled = false;
  static const String _serverUrl = "https://erpappserver.cfapps.in30.hana.ondemand.com/api/notifications/send/topic";
  static const String _apiKey = "api_key";
  bool _isPressed = false;

  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  static final Dio _dio = Dio(BaseOptions(
    baseUrl: _serverUrl,
    headers: {
      "Content-Type": "application/json",
      "x-api-key": _apiKey,
    },
  ));

  @override
  void initState() {
    super.initState();
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
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(
              "Long press the button below to send a SOS alert",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),),
            const SizedBox(height: 20),
            isRegisteredForSOS
                ? GestureDetector(
              onLongPress: () async {
                HapticFeedback.heavyImpact(); // 🔔 vibrate on long press
                await sendTopicNotification();
              },
              onLongPressStart: (_) =>
                  setState(() => _isPressed = true),
              onLongPressEnd: (_) =>
                  setState(() => _isPressed = false),
              child: AnimatedScale(
                scale: _isPressed ? 0.9 : 1.0, // shrink effect
                duration: const Duration(milliseconds: 150),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.red,
                      width: 4,
                    ),
                    color: _isPressed
                        ? Colors.red.withOpacity(0.1)
                        : Colors.transparent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(
                      "images/sos1.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            )
                : ElevatedButton(
              onPressed: () async {
                context.go('/sosregister');
              },
              child: Text('Register Service'),
            ),
          ],
        )
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _registerAsResponder(context);
        },
        label: Text('Register as a responder',style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.red,
        ),),
        icon: Icon(Icons.emergency_outlined),
        backgroundColor: Colors.lightGreen[100], // customize
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> _registerAsResponder(BuildContext context){
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Distress Alarm Responder Registration'),
          content: const Text(
            'You are registering to receive alarm notification for emergency distress signal. Please confirm',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
              child: const Text('Confirm'),
              onPressed: () async{
                // Request permission
                await _requestPermissions();
                await messaging.subscribeToTopic("sos_alarm");
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _requestPermissions() async {
    // Firebase permission
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    // FlutterLocalNotification Permission
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
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      final bool? notificationPermission = await androidImplementation?.requestNotificationsPermission();
      final bool? notificationPolicyAccess = await androidImplementation?.requestNotificationPolicyAccess();
      final bool? fullScreenPermission = await androidImplementation?.requestFullScreenIntentPermission();

      if(notificationPermission! && notificationPolicyAccess! && fullScreenPermission!){
        setState(() {
          _notificationsEnabled = true;
        });
      }
    }
  }

  Future<void> sendTopicNotification() async {
    try {
      Position position = await Geolocator.getCurrentPosition(locationSettings: locationSettings);
      print("lat: ${position.latitude}");
      print("lat: ${position.longitude}");
      print("pos: ${position.toJson()}");
      final response = await Dio().post(
        _serverUrl,
        data: {
          "topic":"sos_alarm",
          "data": {
            "type":"SOS",
            "title":"SOS Alert",
            "body":"Distress signal received",
            "lat": position.latitude.toString(),
            "lng": position.longitude.toString(),
            "custom":"any-other-payload"
          }
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "x-api-key": _apiKey,
          },
        ),
      );
      print("✅ Notification sent: ${response.data}");
    } on DioException catch (e) {
      if (e.response != null) {
        print("❌ Failed: ${e.response?.statusCode}");
        print("Response: ${e.response?.data}");
      } else {
        print("🔥 Error: ${e}");
        print(e.requestOptions);
        print(e.message);
      }
    }
  }

}

class SosRegistration extends StatefulWidget {
  @override
  _SosRegistrationState createState() => _SosRegistrationState();
}

class _SosRegistrationState extends State<SosRegistration> {
  int _step = 0;
  bool _loading = false;
  bool _otpSent = false;
  String serverBaseUrl = "https://erpappserver.cfapps.in30.hana.ondemand.com";
  String apiUrl = '';

  final _salaryCtrl = TextEditingController();
  final _otpCtrl = TextEditingController();

  // Step 1: Send OTP
  Future<void> _sendOtp() async {
    apiUrl = serverBaseUrl + '/api/S4/SOSRegister/'+_salaryCtrl.text;
    setState(() => _loading = true);
    final res = await http.post(
      Uri.parse(apiUrl),
     // body: {"salaryCode": _salaryCtrl.text},
    );
    setState(() => _loading = false);
    print(res);
    setState(() => _otpSent = true);
    if (res.statusCode == 200) {

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Salary Code")));
    }
  }

  // Step 1: Verify OTP
  Future<void> _verifyOtp() async {
    apiUrl = serverBaseUrl + '/api/S4/VerifyOTP';
    setState(() => _loading = true);
    final res = await http.post(
      Uri.parse(apiUrl),
      body: {"salaryCode": _salaryCtrl.text, "otp": _otpCtrl.text},
    );
    setState(() => _loading = false);
    setState(() => _step = 1);
    if (res.statusCode == 200) {

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid OTP")));
    }
  }

  // Step 2: Location
  Future<void> _requestLocation() async {
    final status = await Permission.locationWhenInUse.request();
    if (status.isGranted) {
      setState(() => _step = 2);
      _registerFcm();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Location permission required")));
    }
  }

  // Step 3: FCM
  Future<void> _registerFcm() async {
    setState(() => _loading = true);
    final token = await messaging.getToken();
    print("fcm token: $token");
    if (token != null) {
      setState(() {
        fcmToken = token;
        //salaryCode = _salaryCtrl.text;
        isRegisteredForSOS = true;
        _loading = false;
      });

      await storage.write(key: "salaryCode", value: _salaryCtrl.text);
      await storage.write(key: "fcmToken", value: token);
      await storage.write(key: "SOSRegistration", value: isRegisteredForSOS.toString());

    }
  }

  Widget _buildStepCard() {
    switch (_step) {
      case 0:
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text("Step 1: User Registration", style: Theme.of(context).textTheme.titleLarge),
                TextField(controller: _salaryCtrl, decoration: InputDecoration(labelText: "Salary Code")),
                if (_otpSent)
                  TextField(controller: _otpCtrl, decoration: InputDecoration(labelText: "OTP")),
                if (_loading) Padding(padding: EdgeInsets.all(8), child: CircularProgressIndicator())
              ],
            ),
          ),
        );
      case 1:
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text("Step 2: Location Permission", style: Theme.of(context).textTheme.titleLarge),
                Text("We need your location to send accurate SOS alerts."),
                SizedBox(height: 12),
                Icon(Icons.location_on, color: Colors.red, size: 48),
              ],
            ),
          ),
        );
      case 2:
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: _loading
                ? Center(child: CircularProgressIndicator())
                : Column(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 64),
                Text("Registration Completed!", style: Theme.of(context).textTheme.titleLarge),
                ElevatedButton(
                  onPressed: (){
                    context.go('/sos');
                  },
                  child: Text("Continue"),
                )
              ],
            ),
          ),
        );
      default:
        return SizedBox();
    }
  }

  void _onNext() {
    if (_step == 0) {
      if (!_otpSent) {
        _sendOtp();
      } else {
        _verifyOtp();
      }
    } else if (_step == 1) {
      _requestLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SOS Registration")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            LinearProgressIndicator(value: (_step + 1) / 3),
            SizedBox(height: 20),
            Expanded(child: _buildStepCard()),
            SizedBox(height: 10),
            if (_step < 2)
              ElevatedButton(
                onPressed: _loading ? null : _onNext,
                child: Text(_step == 0 ? (_otpSent ? "Verify OTP" : "Send OTP") : "Allow & Continue"),
              ),
          ],
        ),
      ),
    );
  }
}