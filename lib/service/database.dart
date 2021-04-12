import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_workout/model/user.dart';

CollectionReference usersRef = FirebaseFirestore.instance.collection("Users");
CollectionReference followingRef =
    FirebaseFirestore.instance.collection("following");
UserModel currentUser;

userSetup(String displayName, username, email) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  DocumentSnapshot doc = await usersRef.doc(usersRef.id).get();

  //NOTE: uid = id
  usersRef.doc(uid).set({
    'display_name': displayName,
    'username': username,
    'email': email,
    'uid': uid,
    'presence': true,
    'buddy': '',
  });

  doc = await usersRef.doc(uid).get();

  currentUser = UserModel.fromDocument(doc);

  currentUser = UserModel.fromDocument(doc);
}
