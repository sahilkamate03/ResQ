import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class directionPage extends StatefulWidget {
  const directionPage({super.key});

  @override
  State<directionPage> createState() => _directionPageState();
}

class _directionPageState extends State<directionPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(18.5204, 73.8567),
          zoom: 9.2,
        ),
        nonRotatedChildren: [
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () =>
                    launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
              ),
            ],
          ),
        ],
        children: [
          TileLayer (
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
        ],
      ),
    );
  }
}
