import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'login_page.dart';

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
          CupertinoPageRoute(builder: (ctx) =>  const LoginPage()));
         //GoRouter.of(context).go('/splashscreen/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 60),
              child: SizedBox(
                height: 600,
                width: 400,
                child: Image(
                  image: AssetImage('images/logo-white.png'),
                  fit: BoxFit.fill,
                  width: 300,
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            SpinKitSpinningLines(
              color: Colors.orange,
              lineWidth: 5,
              size: 50.0,
            )
          ],
        ),
      ),
    );
  }
}
