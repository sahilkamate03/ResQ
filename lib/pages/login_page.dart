import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:res_q/functions/shimmering_effect.dart';
import 'package:res_q/pages/splashscreen.dart';
//import 'package:go_router/go_router.dart';
import '../../functions/sign_in.dart';
import '../main.dart';
import 'home_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //initialRoute: '/dashboard',
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const HomePage(),
        '/shimmer': (context) => const ProfilePageShimmer(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final Auth _auth = Auth();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          body: WillPopScope(
            onWillPop: () async {
              if (isLoggedIn == false) {
                SystemNavigator.pop();
              }
              return true;
            },
            child: SingleChildScrollView(
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 0,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 50, top: 70),
                        child: ImageIcon(
                          AssetImage("images/resQ_logo.png"),
                          size: 200,
                          color: Color.fromARGB(255, 75, 175, 80),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.black,
                            focusColor: Colors.black,
                            //hintText: 'Username',
                            labelText: 'username',
                            prefixIcon: IconButton(
                              onPressed: () {},
                              icon: Image.asset('images/profile_logo.png'),
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
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || !value.contains('@')) {
                              setState(() {
                                isLoading = false;
                              });
                              return 'Please Enter valid Email';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            fillColor: Colors.black,
                            //hintText: 'Password',
                            labelText: 'password',
                            prefixIcon: IconButton(
                              icon: Image.asset('images/password logo.png'),
                              color: const Color.fromRGBO(98, 185, 102, 0),
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
                          controller: _passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              setState(() {
                                isLoading = false;
                              });
                              return 'Please Enter correct password';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 55,
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              //to set border radius to button
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.all(10),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              signInUser();
                            }
                          },
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text('Log In'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomSheet: Row(
            children: const [
              SizedBox(
                width: 130,
              ),
              Text(
                'Made with ',
                style: TextStyle(),
              ),
              Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              Text(
                ' by',
                style: TextStyle(),
              ),
              Text(
                ' Null_Byte',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signInUser() async {
    dynamic authResult =
        await _auth.loginUser(_emailController.text, _passwordController.text);
    if (authResult == null) {
      debugPrint('Sign in error. could not be able to login');
      setState(() {
        isLoading = false;
        isLoggedIn = false;
      });
    } else {
      setState(() {
        isLoading = false;
        isLoggedIn = true;
      });
      _emailController.clear();
      _passwordController.clear();
      Navigator.pushNamed(context, '/dashboard');
      //GoRouter.of(context).go('/splashscreen/dashboard');
    }
  }
}
