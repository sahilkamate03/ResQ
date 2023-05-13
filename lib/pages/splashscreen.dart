import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:res_q/pages/home_page.dart';
import '../functions/shimmering_effect.dart';
import 'login_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //initialRoute: '/dashboard',
      home: const HomePage(),
      //home: const HomePage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const HomePage(),
        '/shimmer': (context) => const ProfilePageShimmer(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000)).then((value) {
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (ctx) => const LoginPage()));
      //GoRouter.of(context).go('/splashscreen/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 60),
              child: SizedBox(
                height: 600,
                width: 500,
                child: Image(
                  image: AssetImage('images/resQ_logo.png'),
                  width: 500,
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            SpinKitSpinningLines(
              color: Colors.green,
              lineWidth: 5,
              size: 50.0,
            )
          ],
        ),
      ),
    );
  }
}
