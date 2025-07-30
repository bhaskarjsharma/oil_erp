import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 65,
        scrolledUnderElevation: 0,
        backgroundColor: Color(0xFFE5E5E5),
        title: Center(child:Image.asset('images/oil_logo_with_background.png',height:60),),
        automaticallyImplyLeading: false,
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
  }
}
