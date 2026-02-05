import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_ce/hive.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:oil_erp/hive/models.dart';
import 'package:oil_erp/main.dart';
import 'package:http/http.dart' as http;

class OfflineServices extends StatefulWidget {
  const OfflineServices({super.key});

  @override
  State<OfflineServices> createState() => _OfflineServicesState();
}

class _OfflineServicesState extends State<OfflineServices> {
  bool _loading = false;
  late List<EmpTraining> _trainingData;
  @override
  void initState(){
    super.initState();
    
    final trainingBox = Hive.box<EmpTraining>('emptraining');
    if (trainingBox.values.isEmpty) {
      if (!connectionStatus.contains(ConnectivityResult.none)) {
        _fetchTrainingData();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("No internet connection. Please check your settings"),
          ),
        );
      }
    } else {
      setState(() {
        _trainingData = trainingBox.values.toList();
        _loading = false;
      });
    }
  }

  Future<void> _fetchTrainingData() async {
    final apiUrl = '${serverBaseUrl}s4/trainings';
    setState(() => _loading = true);
    try {
      final res = await http
          .post(
            Uri.parse(apiUrl),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${JWT}',
            },
          )
          .timeout(const Duration(seconds: 15));

      final data = jsonDecode(res.body);

      if (data['success'] == true) {
        final List list = data['data'];
        final trainings = list.map((e) => EmpTraining.fromJson(e)).toList();

        final box = Hive.box<EmpTraining>('emptraining');
        await box.clear();
        await box.addAll(trainings);  

        setState(() {
          _trainingData = trainings;
        });
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Invalid OIL Id")));
      }
    } catch (e) {
      //_showError(e.toString());
    } finally {
      setState(() => _loading = false);
    }
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
                      _getTrainingData();
                    },
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.model_training_outlined,
                            size: 30,
                            color: Color.fromRGBO(227, 30, 36, 1),
                          ),
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
                Text(EmpRegistered.toString()),
                Text(OILId),
                Text(JWT),
                Text(JwtDecoder.getExpirationDate(JWT).toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getTrainingData() async {
    final apiUrl = '${serverBaseUrl}s4/trainings';
    setState(() => _loading = true);
    try {
      final res = await http
          .get(
            Uri.parse(apiUrl),
            headers: {
              'Authorization': 'Bearer $JWT',
              'Content-Type': 'application/json',
            },
            //body: jsonEncode({'pernr': OILId}),
          )
          .timeout(const Duration(seconds: 15));

      final data = jsonDecode(res.body);

      if (data['success'] == true) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Data fetched successfully")));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error in fetching data")));
      }
    } catch (e) {
      //_showError(e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }
}
