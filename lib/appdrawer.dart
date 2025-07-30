import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'main.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => AppDrawerState();
}
class AppDrawerState extends State<AppDrawer> {
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Drawer(
        child: ListView(
            padding: EdgeInsets.zero,
            children:[
              Container(
                height: 270,
                child: DrawerHeader(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            //colors: [Color.fromRGBO(255, 239, 186, 1), Color.fromRGBO(255, 255, 255, 1)]
                            colors: [Colors.red, Colors.black]
                        )
                    ),
                    child: Column(
                      children: [

                      ],
                    )
                ),
              ),
              ListTile(
                leading: Icon(Icons.home,color: Colors.blueAccent, size:25),
                title: const Text('Home'),
                onTap: () {
                  context.go("/");
                },
              ),
              ListTile(
                leading: Icon(Icons.power_settings_new,color: Colors.redAccent, size:25),
                title: const Text('Logout'),
                onTap: () async {
                  final cookieManager = WebViewCookieManager();
                  cookieManager.clearCookies();
                  //await prefs.clear();
                  context.go("/");
                },
              ),
            ]
        )
    );
  }
}