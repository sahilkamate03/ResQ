import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'login_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

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
          backgroundColor: Colors.black,
          actions: <Widget>[
            SpeedDial(
              icon: Icons.settings,
              backgroundColor: Colors.black,
              activeBackgroundColor: Colors.transparent,
              direction: SpeedDialDirection.down,
              children: [
                SpeedDialChild(
                  child: const Icon(Icons.person),
                  label: 'Profile',
                  onTap: () {},
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
              ),
              const Image(
                image: AssetImage('images/dark background.jpg'),
                height: 340,
                width: 410,
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
