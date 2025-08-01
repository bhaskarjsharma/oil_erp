import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:oil_erp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Login extends StatelessWidget {
  /// Constructs a [Login]
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: AppBar(
    title:Image.asset('images/oil_logo_with_background.png',height:55),
    centerTitle: true,
    backgroundColor: Color(0xFFE5E5E5),
    automaticallyImplyLeading: true,
    scrolledUnderElevation: 0,
    ),
      body: Container(
        decoration: BoxDecoration(
          color:Color(0xFFE5E5E5),
        ),
        child: Column(
          children: <Widget>[
            PlatformText(
              'OIL ERP Mobile',
              style:  TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Text color
                letterSpacing: 1.2,  // Optional: spacing between letters
              ),
            ),
            Image.asset('images/banner.gif'),
            SizedBox(
              height: 50,
            ),
            PlatformText(
              'Login to ERP Services',
              style:  TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Text color
                letterSpacing: 1.2,  // Optional: spacing between letters
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color:Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PlatformText(
                      'Please select your login option',
                      style:  TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Text color
                        letterSpacing: 1.2,  // Optional: spacing between letters
                      ),
                    ),
                    PlatformElevatedButton(
                      color: Color(0xFFE5E5E5),
                        material: (_, __) => MaterialElevatedButtonData(
                          style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w700),
                            backgroundColor: Color(0xFFE5E5E5),
                          ),
                        ),
                        cupertino: (_, __) => CupertinoElevatedButtonData(
                          color: Color(0xFFE5E5E5),

                        ),
                      onPressed: ()  {
                        final encodedUrl = Uri.encodeComponent("https://btp-production-f0dzcdvq.launchpad.cfapps.in30.hana.ondemand.com/site?siteId=9a83e36a-4df2-4cda-89e1-750582e0e8a7");
                        context.go('/webview?url=$encodedUrl');
                      },
                      child: PlatformText('Executive Login',style: TextStyle(fontSize: 16,color: Colors.black)),
                    ),
                    PlatformElevatedButton(
                      material: (_, __) => MaterialElevatedButtonData(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w700),
                          backgroundColor: Color(0xFFE5E5E5),
                        ),
                      ),
                      cupertino: (_, __) => CupertinoElevatedButtonData(
                        color: Color(0xFFE5E5E5),
                      ),
                      onPressed: () {
                        final encodedUrl = Uri.encodeComponent("https://ess.oilindia.in");
                        context.go('/webview?url=$encodedUrl');
                      },
                      child: PlatformText('Unionized Employee Login',style: TextStyle(fontSize: 16,color: Colors.black)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Text('')
            ),
            Container(
              decoration: BoxDecoration(
                color:Colors.white70,
              ),
              width: double.infinity,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: PlatformText('\u00A9 2025 Oil India Limited. All rights reserved', style: TextStyle(fontSize: 12)),
                ),
              ),

            )
          ],
        ),
      ),
    );
  }
}

class LoginWebView extends StatefulWidget {
  final String url;
  const LoginWebView({super.key, required this.url});

  @override
  State<LoginWebView> createState() => _LoginWebViewState();
}

class _LoginWebViewState extends State<LoginWebView> {
  late final WebViewController controller;
  int btpCallCount = 0;
  @override
  void initState() {
    print(widget.url);
    super.initState();
    controller = WebViewController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          width: 40,
          child: Image.asset('images/oil_logo_with_background.png'),
        ),
        title: Row(
          children:[
            Text('OIL ERP',style: TextStyle(
              color:Colors.black,
            ),),
            Spacer(),
          ],
        ),
        automaticallyImplyLeading: true,
      ),
      body: WebViewWidget(
        controller: controller
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (url){

              },
              onPageFinished: (url) async {
                // ✅ Condition to redirect
                print('Current URL: ' + url);
                if(url.contains("#Shell-home")){
                  final prefs = await SharedPreferences.getInstance();
                  // set value
                  prefs.setBool('isLoggedIn', true);
                  prefs.setString('last_login', DateTime.now().toIso8601String());
                  if(url == "https://btp-production-f0dzcdvq.launchpad.cfapps.in30.hana.ondemand.com/site?siteId=9a83e36a-4df2-4cda-89e1-750582e0e8a7#Shell-home"){
                    setState(() {
                      loginType = "BTPWZ";
                      backendURL = "https://btp-production-f0dzcdvq.launchpad.cfapps.in30.hana.ondemand.com/site?siteId=9a83e36a-4df2-4cda-89e1-750582e0e8a7&sap-ushell-config=headerless";
                    });
                  }
                  else if(url == "https://ess.oilindia.in/sap/bc/ui2/flp#Shell-home"){
                    setState(() {
                      loginType = "FLP";
                      backendURL = "https://ess.oilindia.in/sap/bc/ui2/flp";
                    });
                  }

                  context.go('/app');
                }
                if (url.contains("error")) {

                }
              },
              onWebResourceError: (error) {
                debugPrint("WebView error: ${error.description}");
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.url)),
      ),
    );
  }
}