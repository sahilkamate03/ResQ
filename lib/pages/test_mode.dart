import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String location = 'Null, Press Button';
  String getDataBtn = 'Refresh';
  bool serverOnline = false;
  late Timer _timer;

  Future<bool> isServerOnline(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  // Future<void> getAddressFromLatLong(Position position) async {
  //   List<Placemark> placemarks =
  //       await placemarkFromCoordinates(position.latitude, position.longitude);
  //   debugPrint(placemarks.toString());
  //   Placemark place = placemarks[0];
  //   address =
  //       '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  //   setState(() {});
  // }

  void sendPostRequest() async {
    Position position = await _getGeoLocationPosition();
    Map<String, String> data = {
      'latitude': '${position.latitude}',
      'longitude': '${position.longitude}',
    };

    // Create a POST request.
    Uri uri = Uri.parse('https://resq.sahilkamate.repl.co/post-location');
    http.Response response = await http.post(
      uri,
      body: data,
    );

    location = 'Lat: ${position.latitude} , Long: ${position.longitude}';

    // Check the response status code.
    if (response.statusCode == 200) {
      // The request was successful.
      print('Request successful');
    } else {
      // The request failed.
      print('Request failed');
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _timer =Timer.periodic(const Duration(seconds: 10), (timer) async {
      serverOnline = await isServerOnline('https://resq.sahilkamate.repl.co');
      sendPostRequest();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Mode'), // Add your desired title text here
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Coordinates Points',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              location,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            // const Text(
            //   response,
            //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            Text('Server Online: $serverOnline'),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  elevation: 4,
                ),
                onPressed: () async {
                  serverOnline =
                      await isServerOnline('https://resq.sahilkamate.repl.co');
                  sendPostRequest();
                  setState(() {});
                  // getAddressFromLatLong(position);
                },
                child: Text(getDataBtn))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel(); // cancel any ongoing timers
    super.dispose();
  }
}
