import 'package:flutter_workout/helpers/get_userInfo.dart';

Future<void> addReceiverNameinSender(String _senderUid) {
  //this function add the receiver's(userB) name into the (userA)sender's firebase under 'buddy'
  return users
      .doc(_senderUid)
      .update({'buddy': '${auth.currentUser.displayName.toString()}'})
      .then((value) => print("Added Buddy to sender's firestore"))
      .catchError((error) => print("Failed to add Buddy: $error"));
}
