import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_workout/helpers/get_token.dart';
import 'package:flutter_workout/helpers/get_userInfo.dart';

Future<void> sendConfirmNotification(receiver) async {
  var postUrl = "https://fcm.googleapis.com/fcm/send";

  var token = await TokenInfo.getToken(receiver);

  final headers = {
    'content-type': 'application/json',
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
          "notification": {
            "title": "Accepted!",
            "body":
                "${auth.currentUser.displayName.toString()} has accepted your request",
          },
          "priority": "high",
          "data": {
            "hasAccept": "true",
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "id": "1",
            "status": "done"
          },
          "to": "$token"
        },
      ),
    );

    if (response.statusCode == 200) {
      print(response.body.toString());
      print('Notification sent');
    } else {
      print(response.body.toString());
    }
  } catch (err) {}
}
