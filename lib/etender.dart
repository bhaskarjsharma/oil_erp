import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ETender extends StatefulWidget {
  final String url;
  const ETender({super.key, required this.url});

  @override
  State<ETender> createState() => _ETenderState();
}

class _ETenderState extends State<ETender> {
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
    return PopScope(
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
      child: PlatformScaffold(
        backgroundColor: Colors.white,
        appBar: PlatformAppBar(
          material: (_, __) => MaterialAppBarData(
            scrolledUnderElevation: 0,
            backgroundColor: Color(0xFFE5E5E5),
          ),
          cupertino: (_, __) => CupertinoNavigationBarData(
            // Issue with cupertino where a bar with no transparency
            // will push the list down. Adding some alpha value fixes it (in a hacky way)
            backgroundColor: Color(0xFFE5E5E5).withAlpha(254),
          ),
          //toolbarHeight: 65,
          //scrolledUnderElevation: 0,
          title: Center(child:Image.asset('images/oil_logo_with_background.png',height:55),),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color:Color(0xFF333333),
              ),
              width: double.infinity,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('e-Procurement Portal', style: TextStyle(fontSize: 24,color: Colors.white)),
                ),
              ),
            ),
            Expanded(
              child: WebViewWidget(
                  controller: controller
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color:Color(0xFFFFFFFF),
              ),
              width: double.infinity,
              child: Center(
                child: SizedBox(
                  height: 30,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      controller.loadRequest(Uri.parse(
                          "https://etender.srm.oilindia.in:1443/sap(bD1lbiZjPTMwMCZkPW1pbg==)/bc/bsp/sap/ros_self_reg/main.htm"
                      ));
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Customize this value
                    ),
                    elevation: 0,
                    icon: Icon(Icons.account_box_outlined, size: 20),
                    label: PlatformText('Supplier Self Registration for E-Tender', style: TextStyle(fontSize: 16)),
                    backgroundColor: Color(0xFFD5DADD),
                    extendedPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              ),
            ),
            SizedBox(height:2),
            Container(
              decoration: BoxDecoration(
                color:Color(0xFFFFFFFF),
              ),
              width: double.infinity,
              child: Center(
                child: SizedBox(
                  height: 30,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      controller.loadRequest(Uri.parse(
                          "https://etender.srm.oilindia.in:1443/sap/bc/webdynpro/sap/zsrm_wdc_download_user_manual"
                      ));
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Customize this value
                    ),
                    elevation: 0,
                    icon: Icon(Icons.article_outlined, size: 20),
                    label: PlatformText('E-Tender User Manual', style: TextStyle(fontSize: 16)),
                    backgroundColor: Color(0xFFD5DADD),
                    extendedPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
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
      ),
    );
  }
}

class SRM extends StatefulWidget {
  final String url;
  const SRM({super.key, required this.url});

  @override
  State<SRM> createState() => _SRMState();
}

class _SRMState extends State<SRM> {
  late final WebViewController controller;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
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
      child: PlatformScaffold(
        backgroundColor: Colors.white,
        appBar: PlatformAppBar(
          material: (_, __) => MaterialAppBarData(
            scrolledUnderElevation: 0,
            backgroundColor: Color(0xFFE5E5E5),
          ),
          cupertino: (_, __) => CupertinoNavigationBarData(
            // Issue with cupertino where a bar with no transparency
            // will push the list down. Adding some alpha value fixes it (in a hacky way)
            backgroundColor: Color(0xFFE5E5E5).withAlpha(254),
          ),
          //toolbarHeight: 65,
          //scrolledUnderElevation: 0,
          title: Center(child:Image.asset('images/oil_logo_with_background.png',height:55),),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color:Color(0xFF333333),
              ),
              width: double.infinity,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('e-Procurement Portal', style: TextStyle(fontSize: 24,color: Colors.white)),
                ),
              ),
            ),
            Expanded(
              child: WebViewWidget(
                  controller: WebViewController()
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
                    ..loadRequest(Uri.parse(widget.url))
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
      ),
    );
  }
}
