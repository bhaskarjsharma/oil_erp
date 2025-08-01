import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  final String url;
  const WebView({super.key, required this.url});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late final WebViewController controller;
  bool isLoading = false;
  int prog = 0;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
          NavigationDelegate(
              onProgress: (int progress) {
                // Update loading bar.
              },
            onPageStarted: (url){
              setState(() {
                isLoading = true;
              });
            }, onPageFinished: (url) async{
            setState(() {
              isLoading = false;
              });
            },
            onNavigationRequest: (NavigationRequest request) {
              return NavigationDecision.navigate;
            },
          ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE5E5E5),
        title: PlatformText(
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
          Expanded(child: isLoading == true ?  Container(
            child: Center(
              child: PlatformCircularProgressIndicator(
                  material: (_, __)  => MaterialProgressIndicatorData(
                    //value: prog < 100 ? prog / 100 : null,
                      strokeWidth: 3,
                      color: Colors.red
                  ),
                  cupertino: (_, __) => CupertinoProgressIndicatorData(
                      animating: true,
                      color: Colors.red
                  )
              ),
            ),
          ) : WebViewWidget(
              controller: controller
          ),
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
    );

/*      PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        print('result $result.toString()');
        print('didPop $didPop');
        if (didPop) {
          return;
        }
        final currentUrl = await controller.currentUrl();
        print('currentUrl: $currentUrl');
        if (currentUrl != null && currentUrl.contains('microsoft')) {
          // Disable WebView back if it's on "home"
          print('At home page. Popping Flutter route.');
          context.go('/login');
          return;
        }
        else if (currentUrl != null && currentUrl.contains('#Shell-home')) {
          // Disable WebView back if it's on "home"
          print('At home page. Popping Flutter route.');
          context.go('/login');
          return;
        }


        final bool shouldPop = await controller.canGoBack() ?? false;
        print('shouldPop $shouldPop');
        if (context.mounted && shouldPop) {
          print('controller.goBack()');
          controller.goBack();
        }
        else{
          print('go()');
          context.go('/');
         // Navigator.pop(context);
        }
      },
      child:
    );*/
  }
}
