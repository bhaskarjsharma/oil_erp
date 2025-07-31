import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';

class Vendor extends StatefulWidget {
  const Vendor({super.key});

  @override
  State<Vendor> createState() => _VendorState();
}

class _VendorState extends State<Vendor> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
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
          Expanded(
            child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      child: PlatformListTile(
                        title: PlatformText("OIL’s 5 years Procurement Plan"),
                        leading: Icon(Icons.open_with_outlined),
                        onTap: (){
                          final encodedUrl = Uri.encodeComponent("https://www.oil-india.com/oils-5-years-procurement-plan");
                          context.go('/vendor/vendorwebview?url=$encodedUrl');
                        },
                      ),
                    ),
                    Card(
                      child: PlatformListTile(
                        title: PlatformText("Procurement Manuals"),
                        leading: Icon(Icons.open_with_outlined),
                        onTap: (){
                          final encodedUrl = Uri.encodeComponent("https://www.oil-india.com/oils-5-years-procurement-plan");
                          context.go('/vendor/vendorwebview?url=$encodedUrl');
                        },
                      ),
                    ),
                    Card(
                      child: PlatformListTile(
                        title: PlatformText("Micro and Small Enterprises - MSEs"),
                        leading: Icon(Icons.open_with_outlined),
                        onTap: (){
                          final encodedUrl = Uri.encodeComponent("https://www.oil-india.com/tender-list/265");
                          context.go('/vendor/vendorwebview?url=$encodedUrl');
                        },
                      ),
                    ),
                    Card(
                      child: PlatformListTile(
                        leading: Icon(Icons.open_with_outlined),
                        title: PlatformText("Micro and Small Enterprises - MSEs"),
                        onTap: (){
                          final encodedUrl = Uri.encodeComponent("https://www.oil-india.com/tender-list/265");
                          context.go('/vendor/vendorwebview?url=$encodedUrl');
                        },
                      ),
                    ),
                    Card(
                      child: PlatformListTile(
                        leading: Icon(Icons.open_with_outlined),
                        title: PlatformText("Procurements on Nomination Basis"),
                        onTap: (){
                          final encodedUrl = Uri.encodeComponent("https://www.oil-india.com/procurements-on-nomination-basis");
                          context.go('/vendor/vendorwebview?url=$encodedUrl');
                        },
                      ),
                    ),
                    Card(
                      child: PlatformListTile(
                        leading: Icon(Icons.open_with_outlined),
                        title: PlatformText("General Notification"),
                        onTap: (){
                          final encodedUrl = Uri.encodeComponent("https://www.oil-india.com/general-notification");
                          context.go('/vendor/vendorwebview?url=$encodedUrl');
                        },
                      ),
                    ),
                    Card(
                      child: PlatformListTile(
                        leading: Icon(Icons.open_with_outlined),
                        title: PlatformText("E-Tender Notification"),
                        onTap: (){
                          final encodedUrl = Uri.encodeComponent("https://www.oil-india.com/e-tender-notification");
                          context.go('/vendor/vendorwebview?url=$encodedUrl');
                        },
                      ),
                    ),
                    Card(
                      child: PlatformListTile(
                        leading: Icon(Icons.open_with_outlined),
                        title: PlatformText("Vendor Awareness Program"),
                        onTap: (){
                          final encodedUrl = Uri.encodeComponent("https://www.oil-india.com/vendor-awareness-program");
                          context.go('/vendor/vendorwebview?url=$encodedUrl');
                        },
                      ),
                    ),
                  ],
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
    );
  }
}
