import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_workout/model/user.dart';

Future<void> userSetup(String displayName, username, email) async {
  CollectionReference usersRef = FirebaseFirestore.instance.collection("Users");
  FirebaseAuth auth = FirebaseAuth.instance;

  UserModel currentUser;
  String uid = auth.currentUser.uid.toString();
  DocumentSnapshot doc = await usersRef.doc(usersRef.id).get();

  //NOTE: uid = id
  usersRef.doc(uid).set({
    'display_name': displayName,
    'username': username,
    'email': email,
    'uid': uid,
  });

  doc = await usersRef.doc(uid).get();

  currentUser = UserModel.fromDocument(doc);

  print('CurrentUser: $currentUser');
  print('displayName: ${currentUser.displayName}');

  return currentUser;
}
