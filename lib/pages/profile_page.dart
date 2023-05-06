import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:res_q/functions/get_Info.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
  // List userProfilesList = [];
  String? name;
  String? email;
  String? info;

  @override
  void initState() {
    super.initState();
    fetchDataBaseList();
  }

/*
  fetchDataBaseList() async {
    dynamic resultant = await DatabaseManager().getUsersList();

    if (resultant == null) {
      debugPrint('unable to retrieve');
    } else {
      setState(() {
        userProfilesList = resultant;
      });
    }
  }
*/
  fetchDataBaseList() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      debugPrint('User is not logged in');
      return;
    }
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Users')
        .doc(user.uid)
        .get();

    if (!snapshot.exists) {
      debugPrint('User document does not exist');
      return;
    }

    setState(() {
      name = snapshot.get('name');
      email = user.email;
      info = snapshot.get('info');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 120,),
                const CircleAvatar(
                  backgroundColor: Color.fromARGB(217, 217, 217, 217),
                  radius: 60,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 22),
                            child: Text(
                              'Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Stack(
                              children: [
                                const TextField(
                                  decoration: InputDecoration(
                                    fillColor: Colors.black,
                                    focusColor: Colors.black,

                                    //hintText: 'Username',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(
                                        width: 4.0,
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    name ?? '',
                                    textScaleFactor: 1.6,
                                    style: const TextStyle(wordSpacing: 1),
                                  ),
                                ),
                                //Text(userProfilesList[0]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 22),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Stack(
                              children: [
                                const TextField(
                                  decoration: InputDecoration(
                                    fillColor: Colors.black,
                                    focusColor: Colors.black,
                                    //hintText: 'sample@gmail.com',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(
                                        width: 4.0,
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    email ?? '',
                                    textScaleFactor: 1.6,
                                    style: const TextStyle(wordSpacing: 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 22),
                            child: Text(
                              'Info',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Stack(
                              children: [
                                const TextField(
                                  decoration: InputDecoration(
                                    fillColor: Colors.black,
                                    focusColor: Colors.black,
                                    //hintText: 'Information',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(
                                        width: 4.0,
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    info ?? '',
                                    textScaleFactor: 1.6,
                                    style: const TextStyle(wordSpacing: 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 40,
                // ),
                // SizedBox(
                //   height: 55,
                //   width: 200,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       FirebaseAuth.instance.signOut();

                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const LoginPage()),
                //       );
                //     },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.green,
                //       elevation: 4,
                //       shape: RoundedRectangleBorder(
                //         //to set border radius to button
                //         borderRadius: BorderRadius.circular(15),
                //       ),
                //       padding: const EdgeInsets.all(10),
                //     ),
                //     child: const Text('Logout'),
                //   ),
                // ),
              ],
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
}
