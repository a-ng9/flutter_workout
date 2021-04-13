import 'dart:convert';

import 'package:flutter_workout/helpers/get_token.dart';
import 'package:flutter_workout/helpers/get_userInfo.dart';
import 'package:http/http.dart' as http;

Future<void> requestBudNotif(receiver) async {
  var postUrl = "https://fcm.googleapis.com/fcm/send";
  var token = await TokenInfo.getToken(receiver);

  final headers = {
    'content-type': 'application/json',
    //Authorization key is the token key from Firebase console/ Project Settings/ Cloud Messaging/ server key
    'Authorization':
        'key=AAAAwYa2W3Y:APA91bEr9X9PX2aLLrBeD_Af-RGXa3yAW2edg7A6Ys5DMCv5Ph3h6x6DOZ7_w9DVDyTyldIKy9E7YksfKUs-R4kpyrvfx6SN2Xuwq0odoLokTu_nt72vlHrZvv3KS2rb1Ny__Vse454m'
  };

  try {
    final url = Uri.parse('$postUrl');
    var response = await http.post(
      url,
      headers: headers,
      body: json.encode(
        {
          //ReadMessage Notification specific data
          "notification": {
            "title": "Workout?",
            "body":
                "Do you want to workout with ${auth.currentUser.displayName.toString()}?",
          },
          "priority": "high",
          //HTML Rest API data
          "data": {
            "hasAccept": "false",
            "senderUid": "${auth.currentUser.uid.toString()}",
            "senderName": "${auth.currentUser.displayName.toString()}",
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "id": "1",
            "status": "done"
          },
          //Receiver's device token to get notification
          "to": "$token"
        },
      ),
    );

    //Check if notification has been sent
    if (response.statusCode == 200) {
      print(response.body.toString());
      print('Notification sent');
    } else {
      print(response.body.toString());
    }
  } catch (err) {}
}
