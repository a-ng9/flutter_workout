import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_workout/helpers/get_userInfo.dart';

final FirebaseMessaging fcm = FirebaseMessaging.instance;

class TokenInfo {
  //get token from userId's firestore database
  static Future<String> getToken(userId) async {
    var token;
    //'users' = from user info - (firebaseFirestore.instance.collection('Users))
    await users.doc(userId).collection('tokens').get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        token = doc.id;
      });
    });

    return token;
  }

  static Future<void> deleteToken() async {
    String fcmToken = await fcm.getToken();
    return users
        .doc(auth.currentUser.uid.toString())
        .collection('tokens')
        .doc(fcmToken)
        .delete()
        .then((value) => print("Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
