import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_workout/const.dart';
import 'package:flutter_workout/components/buddyTile.dart';
import 'package:flutter_workout/components/roundedButton.dart';
import 'package:flutter_workout/helpers/user_status.dart';
import 'package:flutter_workout/screens/workingOut_screen.dart';

import 'package:http/http.dart' as http;

class AskBuddyScreen extends StatefulWidget {
  static const String id = "AskBuddy_Screen";

  @override
  _AskBuddyScreenState createState() => _AskBuddyScreenState();
}

class _AskBuddyScreenState extends State<AskBuddyScreen> {
  static var postUrl = "https://fcm.googleapis.com/fcm/send";

  static Future<void> sendNotification(receiver, msg) async {
    var token = await getToken(receiver);

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
              "title": "Workout?",
              "body":
                  "Do you want to workout with ${auth.currentUser.displayName.toString()}?",
            },
            "priority": "high",
            "data": {
              "hasAccept": "false",
              "senderUid": "${auth.currentUser.uid.toString()}",
              "senderName": "${auth.currentUser.displayName.toString()}",
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

  static Future<String> getToken(userId) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    var token;
    await _db
        .collection('Users')
        .doc(userId)
        .collection('tokens')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        token = doc.id;
      });
    });

    return token;
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    return Scaffold(
      appBar: AppBar(backgroundColor: midNightBlue, elevation: 0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "Buddy?",
              style: TextStyle(fontSize: 34),
            ),
          ),
          Center(child: Icon(Icons.people, size: 150, color: lightRed)),
          Expanded(
            child: StreamBuilder(
                stream: users.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      return auth.currentUser.uid.toString() ==
                              document.data()['uid']
                          ? SizedBox.shrink()
                          : BuddyTile(
                              nameTitle: document.data()['display_name'],
                              onPressed: () async {
                                sendNotification(
                                    document.data()['uid'].toString(),
                                    "Description Message");
                              },
                            );
                    }).toList(),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: RoundedButton(
              colour: lightRed,
              text: "START",
              pressed: () {
                Navigator.pushNamed(context, WorkingOutScreen.id);
              },
            ),
          ),
        ],
      ),
    );
  }
}
