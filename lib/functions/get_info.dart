
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseManager {
  final CollectionReference profileList =
      FirebaseFirestore.instance.collection('Users');

  Future getUsersList() async {
    List itemsList = [];

    try {
      await profileList.get().then((QuerySnapshot) {
        QuerySnapshot.docs.forEach((element) {
          itemsList.add(element.data());
        });
      });
      return itemsList;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
