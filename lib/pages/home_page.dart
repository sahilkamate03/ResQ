import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
//import 'package:go_router/go_router.dart';
//import 'package:res_q/functions/shimmering_effect.dart';
import 'package:res_q/main.dart';
//import 'package:res_q/pages/profile_page.dart';
import 'package:res_q/pages/profile_page.dart';
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

  Future<Widget> buildMyWidget() async {
    try {
      Container mycontainer = Container(
        height: MediaQuery.of(context).size.height - 350,
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

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  String? _currentAddress;
  Position? _currentPosition;

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
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
                Column(
                    // padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    children: [
                      TextField(
                        onChanged: (value) async {
                          if (value.isNotEmpty) {
                            String url =
                                'https://nominatim.openstreetmap.org/search?q=$value&format=json&addressdetails=1&limit=5';
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
                          hintText: 'Search...',
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
                            title: Text(_predictions[index]['display_name']),
                            onTap: () async {
                              // Do something with selected location
                              _searchController.text =
                                  _predictions[index]['display_name'];
                              String selectedName =
                                  _predictions[index]['display_name'];
                              String googleMapsUrl =
                                  'https://www.google.com/maps/dir/?api=1&origin=${selectedName}&destination=18.553075408860977,73.83818629320649';
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
                    ]),
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
        ),
      ),
    );
  }
  
}
