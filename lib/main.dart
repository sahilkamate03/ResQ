import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:res_q/firebase_options.dart';
import 'package:res_q/pages/login_page.dart';
//import 'package:res_q/pages/structure.dart';
//import 'functions/routing.dart';
  bool isLoggedIn = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MainApp());
}

