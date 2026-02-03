import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:oil_erp/main.dart';

class OfflineServices extends StatefulWidget {
  const OfflineServices({super.key});

  @override
  State<OfflineServices> createState() => _OfflineServicesState();
}

class _OfflineServicesState extends State<OfflineServices> {
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
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Text color
            letterSpacing: 1.2, // Optional: spacing between letters
          ),
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: Center(
        child: Expanded(
          child: Container(
            decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              children: <Widget>[
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFFE5E5E5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {
                      
                    },
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.model_training_outlined,
                            size: 30, color: Color.fromRGBO(227, 30, 36, 1)),
                          PlatformText(
                            'Training Data',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Text(JWT),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
