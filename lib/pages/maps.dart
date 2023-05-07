import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class directionPage extends StatefulWidget {
  const directionPage({super.key});

  @override
  State<directionPage> createState() => _directionPageState();
}

class _directionPageState extends State<directionPage> {
  late MapboxMapController _controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MapboxMap(
        accessToken: "<your-access-token>",
        initialCameraPosition: const CameraPosition(
          target: LatLng(37.7749, -122.4194),
          zoom: 12.0,
        ),
        onMapCreated: (MapboxMapController controller) {
          _controller = controller;
        },
      ),
    );
  }
}
