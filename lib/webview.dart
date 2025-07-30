import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
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
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        backgroundColor: Color(0xFFE5E5E5),
        title: Center(
          child: PlatformText(
            'OIL ERP Mobile',
            style:  TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Text color
              letterSpacing: 1.2,  // Optional: spacing between letters
            ),
          )
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(child: isLoading == true ?  Container(
            child: const Center(
              child: CircularProgressIndicator(),
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
  }
}
