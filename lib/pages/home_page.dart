import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
//import 'package:go_router/go_router.dart';
//import 'package:res_q/functions/shimmering_effect.dart';
import 'package:res_q/main.dart';
//import 'package:res_q/pages/profile_page.dart';
import 'package:res_q/pages/profile_page.dart';
import 'package:res_q/pages/test_mode.dart';
import 'data_page.dart';
import 'login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _predictions = [];

  String _greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 18) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  late Position position;

  @override
  void initState() {
    super.initState();
    _initPosition();
  }

  void _initPosition() async {
    position = await _getGeoLocationPosition();
    setState(() {});
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

  Future<Widget> buildMyWidget() async {
    try {
      Container mycontainer = Container(
        // height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(left: 10, right: 1, bottom: 20),
        child: FlutterMap(
          options: MapOptions(
            // await _getGeoLocationPosition(),
            // ignore: unnecessary_null_comparison
            center: position != null
                ? LatLng(position.latitude, position.longitude)
                : LatLng(18.5204, 73.8567),
            zoom: 11.5,
          ),
          nonRotatedChildren: [
            RichAttributionWidget(
              attributions: [
                TextSourceAttribution(
                  'OpenStreetMap contributors',
                  onTap: () => launchUrl(
                      Uri.parse('https://openstreetmap.org/copyright')),
                ),
              ],
            ),
          ],
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
          ],
        ),
      );
      return mycontainer;
    } catch (e) {
      debugPrint('Error creating the map widget');
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(_greeting()),
            backgroundColor: const Color.fromARGB(255, 75, 175, 80),
            actions: <Widget>[
              SpeedDial(
                icon: Icons.settings,
                backgroundColor: const Color.fromARGB(255, 75, 175, 80),
                activeBackgroundColor: const Color.fromARGB(255, 75, 175, 80),
                elevation: 0.0,
                direction: SpeedDialDirection.down,
                children: [
                  SpeedDialChild(
                    child: const Icon(Icons.person),
                    label: 'Profile',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                      //GoRouter.of(context).go('/splashscreen/profile');
                    },
                  ),
                  SpeedDialChild(
                    child: const Icon(Icons.dataset_rounded),
                    label: 'Data',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DataPage()),
                      );
                    },
                  ),
                  SpeedDialChild(
                    child: const Icon(
                      Icons.add_road,
                    ),
                    backgroundColor: Colors.white,
                    label: 'Test Mode',
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      isLoggedIn = false;
                      //GoRouter.of(context).go('/splashscreen/login');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyApp()),
                      );
                    },
                  ),
                  SpeedDialChild(
                    child: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.red,
                    label: 'Logout',
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      isLoggedIn = false;
                      //GoRouter.of(context).go('/splashscreen/login');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
          body: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                        // padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        children: [
                          TextField(
                            onChanged: (value) async {
                              if (value.isNotEmpty) {
                                String url =
                                    'https://nominatim.openstreetmap.org/search?q=$value+pune&countrycodes=IN&format=json&viewbox=73.739,18.397,74.020,18.629&bounded=1&limit=5';
                                http.Response response =
                                    await http.get(Uri.parse(url));
                                setState(() {
                                  _predictions = jsonDecode(response.body);
                                });
                              } else {
                                setState(() {
                                  _predictions = [];
                                });
                              }
                            },
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search location...',
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _predictions = [];
                                  });
                                },
                              ),
                              prefixIcon: IconButton(
                                icon: const Icon(Icons.search),
                                color: Colors.black,
                                onPressed: () {},
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide: BorderSide(
                                  width: 4.0,
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: _predictions.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title:
                                    Text(_predictions[index]['display_name']),
                                onTap: () async {
                                  // Do something with selected location
                                  _searchController.text =
                                      _predictions[index]['display_name'];
                                  String selectedName =
                                      _predictions[index]['display_name'];
                                  String googleMapsUrl =
                                      'https://www.google.com/maps/dir/?api=1&origin=18.553023,73.838207&destination=$selectedName';
                                  if (await canLaunchUrl(
                                      Uri.parse(googleMapsUrl))) {
                                    await launchUrl(Uri.parse(googleMapsUrl),
                                        mode: LaunchMode
                                            .externalNonBrowserApplication);
                                  } else {
                                    throw 'Could not launch $googleMapsUrl';
                                  }
                                  setState(() {
                                    _predictions = [];
                                  });
                                },
                              );
                            },
                          ),
                        ])),
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: FutureBuilder(
                    future: buildMyWidget(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data!;
                      }
                      return const CircularProgressIndicator(
                        color: Colors.green,
                        strokeWidth: 3,
                      );
                    },
                  ),
                  /*
                  Container(
                    height: MediaQuery.of(context).size.height - 280,
                    padding: const EdgeInsets.only(left: 10, right: 10),
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
                              onTap: () => launchUrl(Uri.parse(
                                  'https://openstreetmap.org/copyright')),
                            ),
                          ],
                        ),
                      ],
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                      ],
                    ),
                  ),
                  */
                )
              ],
            ),
          ),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            // isExtended: true,
            backgroundColor: Colors.green,
            onPressed: () async {
              position = await _getGeoLocationPosition();
              setState(() {
                position;
              });
            },
            child: const Icon(Icons.gps_fixed),
          ),
        ),
      ),
    );
  }
}
