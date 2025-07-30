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
            child: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: (){
                        final encodedUrl = Uri.encodeComponent("https://www.oil-india.com/oils-5-years-procurement-plan");
                        context.go('/webview?url=$encodedUrl');
                      },
                      child: Card(
                        child: ListTile(
                          title: Text("OIL’s 5 years Procurement Plan"),
                          leading: Icon(Icons.open_with_outlined),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        final encodedUrl = Uri.encodeComponent("https://www.oil-india.com/procurement-manuals");
                        context.go('/webview?url=$encodedUrl');
                      },
                      child: Card(
                        child: ListTile(
                          title: Text("Procurement Manuals"),
                          leading: Icon(Icons.open_with_outlined),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        final encodedUrl = Uri.encodeComponent("https://www.oil-india.com/tender-list/265");
                        context.go('/webview?url=$encodedUrl');
                      },
                      child: Card(
                        child: ListTile(
                          title: Text("Micro and Small Enterprises - MSEs"),
                          leading: Icon(Icons.open_with_outlined),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        final encodedUrl = Uri.encodeComponent("https://www.oil-india.com/tender-list/265");
                        context.go('/webview?url=$encodedUrl');
                      },
                      child: Card(
                        child: ListTile(
                          leading: Icon(Icons.open_with_outlined),
                          title: Text("Micro and Small Enterprises - MSEs"),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        final encodedUrl = Uri.encodeComponent("https://www.oil-india.com/procurements-on-nomination-basis");
                        context.go('/webview?url=$encodedUrl');
                      },
                      child: Card(
                        child: ListTile(
                          leading: Icon(Icons.open_with_outlined),
                          title: Text("Procurements on Nomination Basis"),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        final encodedUrl = Uri.encodeComponent("https://www.oil-india.com/general-notification");
                        context.go('/webview?url=$encodedUrl');
                      },
                      child: Card(
                        child: ListTile(
                          leading: Icon(Icons.open_with_outlined),
                          title: Text("General Notification"),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        final encodedUrl = Uri.encodeComponent("https://www.oil-india.com/e-tender-notification");
                        context.go('/webview?url=$encodedUrl');
                      },
                      child: Card(
                        child: ListTile(
                          leading: Icon(Icons.open_with_outlined),
                          title: Text("E-Tender Notification"),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        final encodedUrl = Uri.encodeComponent("https://www.oil-india.com/vendor-awareness-program");
                        context.go('/webview?url=$encodedUrl');
                      },
                      child: Card(
                        child: ListTile(
                          leading: Icon(Icons.open_with_outlined),
                          title: Text("Vendor Awareness Program"),
                        ),
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
