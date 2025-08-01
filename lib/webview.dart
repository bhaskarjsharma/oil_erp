import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  final String url;
  const WebView({super.key, required this.url});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late final InAppWebViewController webViewController;
  double progress = 0;

  @override
  void initState() {
    super.initState();
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
          progress < 1.0
              ? LinearProgressIndicator(value: progress)
              : Container(),
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(widget.url)),
              initialSettings: InAppWebViewSettings(
                useOnDownloadStart: true,
              ),
              onProgressChanged: (controller,int progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onDownloadStartRequest: (controller, request) async {
                final downloadUrl = request.url.toString();
                final filename = request.suggestedFilename ?? "file.pdf";
                final directory = await getDownloadsDirectory();
                final filePath = '${directory?.path}/$filename';

                final cookies = await CookieManager.instance().getCookies(url: request.url);
                final cookieHeader = cookies.map((e) => "${e.name}=${e.value}").join("; ");

                try {
                  final response = await Dio().download(
                    downloadUrl,
                    filePath,
                    options: Options(
                      headers: {
                        'Cookie': cookieHeader,
                      },
                    ),
                    onReceiveProgress: (received, total) {
                      if (total != -1) {
                        setState(() {
                          progress = received / total;
                        });
                      }
                    },
                  );
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("File downloaded successfully"),
                  ));
                  OpenFile.open(filePath);
                } catch (e) {
                  debugPrint('Download failed: $e');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Failed to download file."),
                  ));
                }
              },
/*              onPermissionRequest: (controller, request) async {
                return PermissionResponse(
                    resources: request.resources,
                    action: PermissionResponseAction.GRANT);
              },*/
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color:Color(0xFFE5E5E5),
            ),
            padding: EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                PlatformIconButton(
                  icon: Icon(PlatformIcons(context).back,size: 20,),
                  onPressed: () {
                    webViewController?.goBack();
                  },
                ),
                PlatformIconButton(
                  icon: Icon(PlatformIcons(context).refresh,size: 20,),
                  onPressed: () {
                    webViewController?.reload();
                  },
                ),
                PlatformIconButton(
                  icon: Icon(PlatformIcons(context).forward,size: 20,),
                  onPressed: () {
                    webViewController?.goForward();
                  },
                ),
              ],
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
