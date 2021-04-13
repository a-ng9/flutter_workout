import 'package:flutter_workout/helpers/get_userInfo.dart';

Future<void> addSenderNameInReceiver(String name) {
  //this function adds the sender's(userA) name into the (userB)receiver's firebase under 'buddy'
  return users
      .doc(auth.currentUser.uid.toString())
      .update({'buddy': '$name'})
      .then((value) => print("Added Buddy to receiver's firestore"))
      .catchError((error) => print("Failed to add Buddy: $error"));
}
