import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';


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
      body: Column(
        children: [
          progress < 1.0
              ? LinearProgressIndicator(value: progress)
              : Container(),
          Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri("https://ess.oilindia.in")),
                initialSettings: InAppWebViewSettings(
                  useOnDownloadStart: true,
                ),
                onProgressChanged: (controller,int progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
                onPermissionRequest: (controller, request) async {
                  return PermissionResponse(
                      resources: request.resources,
                      action: PermissionResponseAction.GRANT);
                },
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                onDownloadStartRequest: (controller, request) async {
                  print("onDownloadStartRequest $url");
                  final downloadUrl = request.url.toString();
                  final filename = request.suggestedFilename ?? "file.pdf";
                  print("filename $filename");
                  final directory = await getDownloadsDirectory();
                  print("directory $directory");
                  final filePath = '${directory?.path}/$filename';
                  print("filePath $filePath");

                  final cookies = await CookieManager.instance().getCookies(url: request.url);
                  print("cookies $cookies");
                  final cookieHeader = cookies.map((e) => "${e.name}=${e.value}").join("; ");
                  print("cookieHeader $cookieHeader");

                  try {
                    final response = await Dio().download(
                      downloadUrl,
                      filePath,
                      options: Options(
                        headers: {
                          'Cookie': cookieHeader,
                        },
                      ),
                    );
                    OpenFile.open(filePath);
                    //final file = File(filePath);
                    //await file.writeAsBytes(response.data);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("File downloaded"),
                    ));
                  } catch (e) {
                    debugPrint('Download failed: $e');
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Failed to download file."),
                    ));
                  }
                },
/*                shouldOverrideUrlLoading:
                    (controller, navigationAction) async {
                  var uri = navigationAction.request.url!;
                  print('url: $uri');
                  return NavigationActionPolicy.ALLOW;
                },*/
              )
          ),
          OverflowBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: const Icon(Icons.arrow_back),
                onPressed: () {
                  webViewController?.goBack();
                },
              ),
              ElevatedButton(
                child: const Icon(Icons.arrow_forward),
                onPressed: () {
                  webViewController?.goForward();
                },
              ),
              ElevatedButton(
                child: const Icon(Icons.refresh),
                onPressed: () {
                  webViewController?.reload();
                },
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color:Colors.white70,
            ),
            width: double.infinity,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Text('\u00A9 2025 Oil India Limited. All rights reserved', style: TextStyle(fontSize: 12)),
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
