//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../functions/sign_in.dart';
import 'home_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const HomePage(),
      },
      /*
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        },
      ),
      */
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
  /*
  final bool _isLogin = true;

  handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.value.text;
    final password = _passwordController.value.text;
    if (_isLogin) {
      //await Auth().signInWithEmailAndPassword(email, password);
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(246, 246, 246, 246),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 120,
                  ),
                  const CircleAvatar(
                    backgroundColor: Color.fromARGB(217, 217, 217, 217),
                    radius: 60,
                    child: Icon(
                      Icons.people_alt,
                      size: 80,
                      color: Colors.black,
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
                        hintText: 'Username',
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
                      decoration: InputDecoration(
                        fillColor: Colors.black,
                        hintText: 'Password',
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
                      //onPressed: () => handleSubmit(),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signInUser();
                        }
                      },
                      child: const Text('Log In'),
                    ),
                  ),
                ],
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
    );
  }

    void signInUser() async {
    dynamic authResult =
        await _auth.loginUser(_emailController.text, _passwordController.text);
    if (authResult == null) {
      print('Sign in error. could not be able to login');
    } else {
      _emailController.clear();
      _passwordController.clear();
      Navigator.pushNamed(context, '/dashboard');
    }
  }
}

