import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:oil_erp/webviewstatic.dart';
import 'company.dart';
import 'home.dart';
import 'login.dart';
import 'vendor.dart';
import 'webview.dart';

var loginType = "";
var backendURL = "";

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Home();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'vendor',
          builder: (BuildContext context, GoRouterState state) => Vendor(),
        ),
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) => Login(),
        ),
        GoRoute(
          path: 'company',
          builder: (BuildContext context, GoRouterState state) => CompanyProfilePage(),
        ),
        GoRoute(
          path: 'webview',  // ✅ no path parameter here
          builder: (context, state) {
            final url = state.uri.queryParameters['url'];
            if (url == null || url.isEmpty) {
              return const Scaffold(body: Center(child: Text("Missing URL")));
            }
            return WebView(url: url);
          },
        ),
        GoRoute(
          path: 'webviewstatic',  // ✅ no path parameter here
          builder: (context, state) {
            final content = state.uri.queryParameters['htmlSource'];
            if (content == null || content.isEmpty) {
              return const Scaffold(body: Center(child: Text("Missing URL")));
            }
            return WebViewStatic(htmlSource: content);
          },
        ),
      ],
    ),


  ],
);

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // handle exceptions caused by making main async.
  runApp(const MainApp());
}


class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();

}
class _MainAppState extends State<MainApp>{
  ThemeMode? themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    final materialLightTheme = ThemeData.light();
    final materialDarkTheme = ThemeData.dark();

    const darkDefaultCupertinoTheme =
    CupertinoThemeData(brightness: Brightness.dark);
    final cupertinoDarkTheme = MaterialBasedCupertinoThemeData(
      materialTheme: materialDarkTheme.copyWith(
        cupertinoOverrideTheme: CupertinoThemeData(
          brightness: Brightness.dark,
          barBackgroundColor: darkDefaultCupertinoTheme.barBackgroundColor,
          textTheme: CupertinoTextThemeData(
            primaryColor: Colors.white,
            navActionTextStyle:
            darkDefaultCupertinoTheme.textTheme.navActionTextStyle.copyWith(
              color: const Color(0xF0F9F9F9),
            ),
            navLargeTitleTextStyle: darkDefaultCupertinoTheme
                .textTheme.navLargeTitleTextStyle
                .copyWith(color: const Color(0xF0F9F9F9)),
          ),
        ),
      ),
    );
    final cupertinoLightTheme =
    MaterialBasedCupertinoThemeData(materialTheme: materialLightTheme);

    return PlatformProvider(
      settings: PlatformSettingsData(
        iosUsesMaterialWidgets: true,
        iosUseZeroPaddingForAppbarPlatformIcon: true,
      ),
      builder: (context) =>
          PlatformTheme(
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
              routerConfig: router
            ),
          ),
    );
    //return MaterialApp.router(routerConfig: router);
  }
}
