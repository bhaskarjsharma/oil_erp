import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';

import 'main.dart';

class Home extends StatelessWidget {
  /// Constructs a [Home]
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: AppBar(
        title:Image.asset('images/oil_logo_with_background.png',height:55),
        centerTitle: true,
        backgroundColor: Color(0xFFE5E5E5),
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color:Color(0xFFE5E5E5),
        ),
        child: Column(
          children: <Widget>[
            //Image.asset('images/oil_logo_with_background.png',width:65),
            PlatformText(
              'OIL ERP Mobile',
              style:  TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Colors.black, // Text color
                letterSpacing: 1.2,  // Optional: spacing between letters
              ),
            ),
            Image.asset('images/banner.gif'),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color:Color(0xFFFFFFFF),
                ),
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(10),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  children: <Widget>[
/*                    InkWell(
                      onTap: (){
                        context.go('/company');
                      },
                      child: Text('company'),
                    ),*/
                    launchScreenCard(
                        "Company profile",
                        const Icon(Icons.supervisor_account_outlined,
                            size: 30, color: Color.fromRGBO(227, 30, 36, 1)),
                        Colors.blue,"page","/company", context
                    ),
/*                    launchScreenCard(
                        "Company profile",
                        Icon(Icons.business_outlined,
                            size: 30, color: const Color.fromRGBO(227, 30, 36, 1)),
                        Colors.blue,"static_html","company.html", context
                    ),*/
                    launchScreenCard(
                        "Our Leaders",
                        const Icon(Icons.supervisor_account_outlined,
                            size: 30, color: Color.fromRGBO(227, 30, 36, 1)),
                        Colors.blue,"page","/leadership", context
                    ),
/*                    launchScreenCard(
                        "Our Leaders",
                        const Icon(Icons.group_add_outlined,
                            size: 30, color: Color.fromRGBO(227, 30, 36, 1)),
                        Colors.blue,"static_html","leadership.html", context
                    ),*/
                    launchScreenCard(
                        "e-tender",
                        const Icon(Icons.shopping_cart_outlined,
                            size: 30, color: Colors.red),
                        Colors.blue,"etender", "https://etender.srm.oilindia.in/irj/portal",context
                    ),
/*                    launchScreenCard(
                        "e-tender",
                        const Icon(Icons.shopping_cart_outlined,
                            size: 30, color: Colors.red),
                        Colors.blue,"url", "https://etender.srm.oilindia.in/irj/portal",context
                    ),*/
                    launchScreenCard(
                        "Vendor Invoice Portal",
                        const Icon(Icons.receipt_long_outlined,
                            size: 30, color: Color.fromRGBO(227, 30, 36, 1)),
                        Colors.blue,"url","https://vim.oilindia.in/velocious-portal-app/", context
                    ),
                    launchScreenCard(
                        "Tender Notifications",
                        const Icon(Icons.feed_outlined,
                            size: 30, color: Color.fromRGBO(227, 30, 36, 1)),
                        Colors.blue,"url","https://www.oil-india.com/tender-list/63", context
                    ),
                    launchScreenCard(
                        "Annual report",
                        const Icon(Icons.request_page_outlined,
                            size: 30, color: Color.fromRGBO(227, 30, 36, 1)),
                        Colors.blue,"url","https://www.oil-india.com/financial-results", context
                    ),
                    launchScreenCard(
                        "Vendor Zone",
                        const Icon(Icons.supervisor_account_outlined,
                            size: 30, color: Color.fromRGBO(227, 30, 36, 1)),
                        Colors.blue,"page","/vendor", context
                    ),
                    launchScreenCard(
                        "Corporate Social Responsibility",
                        const Icon(Icons.diversity_2_outlined,
                            size: 30, color: Color.fromRGBO(227, 30, 36, 1)),
                        Colors.blue,"static_html","csr.html", context
                    ),
/*                    launchScreenCard(
                        "Contact Us",
                        const Icon(Icons.supervisor_account_outlined,
                            size: 30, color: Color.fromRGBO(227, 30, 36, 1)),
                        Colors.blue,"page","/contact", context
                    ),*/
                    launchScreenCard(
                        "Contact Us",
                        const Icon(Icons.contact_mail_outlined,
                            size: 30, color: Color.fromRGBO(227, 30, 36, 1)),
                        Colors.blue,"static_html","contact.html", context
                    ),
                    launchScreenCard(
                        "Privacy Policy",
                        const Icon(Icons.policy_outlined,
                            size: 30, color: Color.fromRGBO(227, 30, 36, 1)),
                        Colors.blue,"static_html","privacy.html", context
                    ),
                    launchScreenCard(
                        "About the App",
                        const Icon(Icons.perm_device_info_outlined,
                            size: 30, color: Color.fromRGBO(227, 30, 36, 1)),
                        Colors.blue,"static_html","about.html", context
                    ),
/*                    launchScreenCard(
                        "Test Page",
                        const Icon(Icons.supervisor_account_outlined,
                            size: 30, color: Color.fromRGBO(227, 30, 36, 1)),
                        Colors.blue,"page","/test", context
                    ),*/
                  ],
                ),
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
                      context.go('/login');
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Customize this value
                    ),
                    elevation: 0,
                    icon: Icon(Icons.lock_person_outlined, size: 20),
                    label: PlatformText('Secured Services', style: TextStyle(fontSize: 16)),
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
                  child: Text('\u00A9 2025 Oil India Limited. All rights reserved', style: TextStyle(fontSize: 12)),
                ),
              ),

            )
          ],
        ),
      ),
    );
  }

  Widget launchScreenCard(
    String title,
    Widget icon,
    MaterialColor colour, String navType, String route, BuildContext context
  ) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color:Color(0xFFE5E5E5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          switch (navType){
            case "page":
              context.go(route);
            case "url":
              final encodedUrl = Uri.encodeComponent(route);
              context.go('/webview?url=$encodedUrl');
              break;
            case "etender":
              final encodedUrl = Uri.encodeComponent(route);
              context.go('/etender?url=$encodedUrl');
              break;
            case "static_html":
              context.go('/webviewstatic?htmlSource=$route');
              break;
          }
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              PlatformText(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,fontSize: 14, color: Colors.black,),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
