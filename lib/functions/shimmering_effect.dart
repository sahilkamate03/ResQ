import 'package:flutter/material.dart';
//import 'package:res_q/pages/profile_page.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePageShimmer extends StatefulWidget {
  const ProfilePageShimmer({Key? key}) : super(key: key);
  @override
  State<ProfilePageShimmer> createState() => _ProfilePageShimmerState();
}

class _ProfilePageShimmerState extends State<ProfilePageShimmer> {
  /*
  @override
  void initState() {
    super.initState();
    fetchDataBaseList();
  }

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
    } else {
      setState(() {
        name = snapshot.get('name');
        email = user.email;
        info = snapshot.get('info');
      });
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (ctx) =>  const ProfilePage()));
      
    }
  }
  
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfilePage(),
        ),
      );
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Shimmer.fromColors(
        baseColor: Colors.grey[350]!,
        highlightColor: const Color.fromARGB(26, 8, 182, 52),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  child: const Center(
                    child: CircleAvatar(
                      radius: 90.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 50.0,
                          width: 500.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 50.0,
                          width: 500.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 50.0,
                          width: 500.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
