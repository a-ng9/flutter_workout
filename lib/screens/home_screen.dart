import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workout/screens/friends_screens/friends_screen.dart';
import 'package:flutter_workout/screens/report_screen.dart';
import 'package:flutter_workout/screens/workingOut_screen.dart';
import 'package:flutter_workout/screens/workoutList_screen.dart';

import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  static const String id = 'homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  static var postUrl = "https://fcm.googleapis.com/fcm/send";

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  static Future<void> sendNotification(receiver) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

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
              "title": "Accepted!",
              "body":
                  "${_auth.currentUser.displayName.toString()} has accepted your request",
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

  _saveDeviceToken(uid) async {
    // Get the token for this device
    String fcmToken = await _fcm.getToken();

    // Save it to Firestore
    if (fcmToken != null) {
      var tokens =
          _db.collection('Users').doc(uid).collection('tokens').doc(fcmToken);

      await tokens
          .set({
            'token': fcmToken,
            'createdAt': FieldValue.serverTimestamp(), // optional
          })
          .then((value) => print("Device Token SAVED!"))
          .catchError((error) => print("Failed to update user: $error"));
    }
  }

  Future<void> updateDeviceToken() async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    String fcmToken = await _fcm.getToken();
    return users
        .doc(_auth.currentUser.uid.toString())
        .collection('tokens')
        .doc(fcmToken)
        .update({
          'token': fcmToken,
          'createdAt': FieldValue.serverTimestamp(),
        })
        .then((value) => print("Device Token Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> addSenderNameInReceiver(String name) {
    //this function add the sender's(userA) name into the (userB)receiver's firebase under 'buddy'
    return users
        .doc(_auth.currentUser.uid.toString())
        .update({'buddy': '$name'})
        .then((value) => print("Added Buddy to receiver's firestore"))
        .catchError((error) => print("Failed to add Buddy: $error"));
  }

  Future<void> addReceiverNameinSender(String _senderUid) {
    //this function add the receiver's(userB) name into the (userA)sender's firebase under 'buddy'
    return users
        .doc(_senderUid)
        .update({'buddy': '${_auth.currentUser.displayName.toString()}'})
        .then((value) => print("Added Buddy to sender's firestore"))
        .catchError((error) => print("Failed to add Buddy: $error"));
  }

  //showDialog to ask workout
  Future requestDialog(RemoteMessage message) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: ListTile(
          title: Text(message.notification.title ?? 'null'),
          subtitle: Text(message.notification.body ?? 'null'),
        ),
        actions: <Widget>[
          TextButton(
              child: Text('Yes'),
              onPressed: () {
                addSenderNameInReceiver(message.data["senderName"]);
                addReceiverNameinSender(message.data["senderUid"]);
                sendNotification(message.data["senderUid"].toString());
                Navigator.pushReplacementNamed(context, WorkingOutScreen.id);
              }),
          TextButton(
            child: Text('No'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  //showDialog to tell userB has accepted
  Future acceptDialog(RemoteMessage message) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        content: ListTile(
          title: Text(message.notification.title ?? 'null'),
          subtitle: Text(message.notification.body ?? 'null'),
        ),
        actions: <Widget>[
          TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, WorkingOutScreen.id);
              }),
        ],
      ),
    );
  }

  int _selectedScreen = 1;
  final _screenOptions = [
    ReportScreen(),
    WorkoutListScreen(),
    FriendsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _saveDeviceToken(_auth.currentUser.uid.toString());

    //when app is opned
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: $message");
      if (message.data['hasAccept'] == "true") {
        acceptDialog(message);
      } else {
        requestDialog(message);
      }
    });

    ///When app is not opened
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print("onMessage: $message");
      requestDialog(message);
      if (message.data['hasAccept'] == "true") {
        acceptDialog(message);
      } else {
        requestDialog(message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screenOptions[_selectedScreen],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreen,
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(size: 30),
        items: [
          BottomNavigationBarItem(
            // icon: Icon(Icons.bar_chart_sharp),
            icon: Icon(Icons.account_circle_outlined),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_kabaddi_sharp),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined),
            label: 'Friends',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedScreen = index;
          });
        },
      ),
    );
  }
}
