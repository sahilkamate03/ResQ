import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:res_q/pages/profile_page.dart';
import 'package:res_q/pages/maps.dart';
import 'login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Good Morning'),
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
                  },
                ),
                SpeedDialChild(
                  child: const Icon(Icons.map),
                  // backgroundColor: Colors.red,
                  label: 'Map',
                  onTap: () {
                    FirebaseAuth.instance.signOut();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const directionPage()),
                    );
                  },
                ),
                SpeedDialChild(
                  child: const Icon(Icons.logout, color: Colors.white,),
                  backgroundColor: Colors.red,
                  label: 'Logout',
                  onTap: () {
                    FirebaseAuth.instance.signOut();

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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => _searchController.clear(),
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
              ),
              const SizedBox(
                height: 50,
              ),Container(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
