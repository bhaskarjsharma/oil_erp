import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class NotificationDetails extends StatelessWidget {
  final Map<String, dynamic> data;

  const NotificationDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final title = data['title'] ?? "No Title";
    final body = data['body'] ?? "No Body";
    double lat = double.tryParse(data['lat']?.toString() ?? '') ?? 0.0;
    double lng = double.tryParse(data['lng']?.toString() ?? '') ?? 0.0;

    return Scaffold(
      appBar: AppBar(title: const Text("SOS Alert Details")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text(body),
          ),
          if (lat != null && lng != null)
            Expanded(
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(lat, lng),
                  initialZoom: 14,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(lat, lng),
                        width: 40,
                        height: 40,
                        child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
                      ),
                    ],
                  ),
                ],
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("No location data provided."),
            ),
        ],
      ),
    );
  }
}