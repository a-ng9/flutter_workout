import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference users = FirebaseFirestore.instance.collection('Users');

class UserStatus {
  //Change(update) user presence in Firestore
  static Future<void> makeUserOnline(uid) {
    return users
        .doc(uid)
        .update({'presence': true})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static Future<void> makeUserOffline(uid) {
    return users
        .doc(uid)
        .update({'presence': false})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
