import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStatic extends StatefulWidget {
  final String htmlSource;
  const WebViewStatic({super.key, required this.htmlSource});

  @override
  State<WebViewStatic> createState() => _WebViewStaticState();
}

class _WebViewStaticState extends State<WebViewStatic> {
  late final WebViewController controller;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
            onPageStarted: (url){
              setState(() {
                isLoading = true;
              });
            }, onPageFinished: (url) async{
          setState(() {
            isLoading = false;
          });
        }
        ),
      );
      loadHtmlFromAssets();
  }

  Future<void> loadHtmlFromAssets() async {
    String fileHtmlContents = await rootBundle.loadString('assets/html/${widget.htmlSource}');
    controller.loadHtmlString(fileHtmlContents);
  }

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
      body: Column(
        children: [
          Expanded(
            child: WebViewWidget(
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
        if (didPop) {
          return;
        }
        final bool shouldPop = await controller.canGoBack() ?? false;
        if (context.mounted && shouldPop) {
          controller.goBack();
        }
        else{
          context.go('/');
          // Navigator.pop(context);
        }
      },
      child: ,
    );*/
  }
}
