import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    hide NotificationDetails;
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:oil_erp/authentication.dart';
import 'package:oil_erp/hive/hive_registrar.g.dart';
import 'package:oil_erp/hive/models.dart';
import 'package:oil_erp/offlineservices.dart';
import 'package:oil_erp/vendorweb.dart';
import 'package:oil_erp/webviewstatic.dart';
import 'package:path_provider/path_provider.dart';
import 'company.dart';
import 'contact.dart';
import 'etender.dart';
import 'home.dart';
import 'leadership.dart';
import 'login.dart';
import 'notification.dart';
import 'notifications.dart';
import 'sos.dart';
import 'test.dart';
import 'vendor.dart';
import 'webview.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';

bool isInternetAvailable = false;
late List<ConnectivityResult> connectionStatus;
var loginType = "";
var backendURL = "";
FirebaseMessaging messaging = FirebaseMessaging.instance;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final storage = FlutterSecureStorage();
bool EmpRegistered = false;
late String OILId;
late String JWT;
late String fcmToken;
late bool isRegisteredForSOS;
String serverBaseUrl = "https://oil-erpapp-server-timely-raven-vv.cfapps.in30.hana.ondemand.com/api/";

String apiUrl = '';
Directory? hiveDirectory;

int id = 0;

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return Home();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'vendor',
          builder: (BuildContext context, GoRouterState state) => Vendor(),
          routes: <RouteBase>[
            GoRoute(
              path: 'vendorwebview', // ✅ no path parameter here
              builder: (context, state) {
                final url = state.uri.queryParameters['url'];
                if (url == null || url.isEmpty) {
                  return const Scaffold(
                    body: Center(child: Text("Missing URL")),
                  );
                }
                return VendorWebView(url: url);
              },
            ),
          ],
        ),
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) => Login(),
        ),
        GoRoute(
          path: 'company',
          builder: (BuildContext context, GoRouterState state) =>
              CompanyProfilePage(),
        ),
        GoRoute(
          path: 'leadership',
          builder: (BuildContext context, GoRouterState state) => Leadership(),
        ),
        GoRoute(
          path: 'contact',
          builder: (BuildContext context, GoRouterState state) => ContactUs(),
        ),
        GoRoute(
          path: 'etender', // ✅ no path parameter here
          builder: (context, state) {
            final url = state.uri.queryParameters['url'];
            if (url == null || url.isEmpty) {
              return const Scaffold(body: Center(child: Text("Missing URL")));
            }
            return ETender(url: url);
          },
        ),
        GoRoute(
          path: 'webview', // ✅ no path parameter here
          builder: (context, state) {
            final url = state.uri.queryParameters['url'];
            if (url == null || url.isEmpty) {
              return const Scaffold(body: Center(child: Text("Missing URL")));
            }
            return WebView(url: url);
          },
        ),
        GoRoute(
          path: 'webviewstatic', // ✅ no path parameter here
          builder: (context, state) {
            final content = state.uri.queryParameters['htmlSource'];
            if (content == null || content.isEmpty) {
              return const Scaffold(body: Center(child: Text("Missing URL")));
            }
            return WebViewStatic(htmlSource: content);
          },
        ),
        GoRoute(
          path: 'offline',
          builder: (BuildContext context, GoRouterState state) =>
              OfflineServices(),
        ),
        GoRoute(
          path: 'otplogin',
          builder: (BuildContext context, GoRouterState state) => OTPLogin(),
        ),
        GoRoute(
          path: 'sos',
          builder: (BuildContext context, GoRouterState state) => SOS(),
        ),
        GoRoute(
          path: 'sosregister',
          builder: (BuildContext context, GoRouterState state) =>
              SosRegistration(),
        ),
        GoRoute(
          path: '/notification',
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>;
            return NotificationDetails(data: data);
          },
        ),
        /*GoRoute(
          path: 'test',
          builder: (BuildContext context, GoRouterState state) => Test(),
        ),*/
      ],
    ),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // handle exceptions caused by making main async.

  connectionStatus = await (Connectivity().checkConnectivity());

  //----------------------- Hive ------------------------------
  hiveDirectory = await getApplicationDocumentsDirectory();
  
  final path = hiveDirectory?.path;
  debugPrint(path);
  Hive.init(path);
  Hive.registerAdapters();
  
  await Hive.openBox<EmpTraining>('emptraining');
  //--------------******** Firebase *****************************
  await Firebase.initializeApp();
  await NotificationService();

  EmpRegistered = (await storage.read(key: "EmpReg"))?.toLowerCase() == "true";
  OILId = await storage.read(key: "OILId") ?? "";
  JWT = await storage.read(key: "JWT") ?? "";
  fcmToken = await storage.read(key: "fcmToken") ?? "";
  
  isRegisteredForSOS =
      (await storage.read(key: "SOSRegistration"))?.toLowerCase() == "true";
  
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ThemeMode? themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    final materialLightTheme = ThemeData.light();
    final materialDarkTheme = ThemeData.dark();

    const darkDefaultCupertinoTheme = CupertinoThemeData(
      brightness: Brightness.dark,
    );
    final cupertinoDarkTheme = MaterialBasedCupertinoThemeData(
      materialTheme: materialDarkTheme.copyWith(
        cupertinoOverrideTheme: CupertinoThemeData(
          brightness: Brightness.dark,
          barBackgroundColor: darkDefaultCupertinoTheme.barBackgroundColor,
          textTheme: CupertinoTextThemeData(
            primaryColor: Colors.white,
            navActionTextStyle: darkDefaultCupertinoTheme
                .textTheme
                .navActionTextStyle
                .copyWith(color: const Color(0xF0F9F9F9)),
            navLargeTitleTextStyle: darkDefaultCupertinoTheme
                .textTheme
                .navLargeTitleTextStyle
                .copyWith(color: const Color(0xF0F9F9F9)),
          ),
        ),
      ),
    );
    final cupertinoLightTheme = MaterialBasedCupertinoThemeData(
      materialTheme: materialLightTheme,
    );

    return PlatformProvider(
      settings: PlatformSettingsData(
        iosUsesMaterialWidgets: true,
        iosUseZeroPaddingForAppbarPlatformIcon: true,
      ),
      builder: (context) => PlatformTheme(
        themeMode: themeMode,
        materialLightTheme: materialLightTheme,
        materialDarkTheme: materialDarkTheme,
        cupertinoLightTheme: cupertinoLightTheme,
        cupertinoDarkTheme: cupertinoDarkTheme,
        matchCupertinoSystemChromeBrightness: true,
        onThemeModeChanged: (themeMode) {
          this.themeMode = themeMode; /* you can save to storage */
        },
        builder: (context) => PlatformApp.router(
          localizationsDelegates: <LocalizationsDelegate<dynamic>>[
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
          ],
          routerConfig: router,
          /*              builder: (context, child) => ResponsiveBreakpoints.builder(
                breakpoints: [
                  const Breakpoint(start: 0, end: 450, name: MOBILE),
                  const Breakpoint(start: 451, end: 800, name: TABLET),
                  const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                  const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
                ],
                child: child!,
              ),*/
        ),
      ),
    );
    //return MaterialApp.router(routerConfig: router);
  }
}
