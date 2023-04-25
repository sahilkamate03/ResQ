import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(246, 246, 246, 246),
        body: Center(
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
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
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
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
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
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 55,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      //to set border radius to button
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(10),
                  ),
                  child: const Text('Log In'),
                ),
              ),
            ],
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
              ' by Null_Byte',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
