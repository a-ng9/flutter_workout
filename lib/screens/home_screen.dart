import 'dart:async';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_workout/screens/friends_screens/friends_screen.dart';
import 'package:flutter_workout/screens/profile_screen.dart';
import 'package:flutter_workout/screens/workingOut_screen.dart';
import 'package:flutter_workout/screens/workoutList_screen.dart';
import 'package:flutter_workout/service/add_ReceiverName.dart';
import 'package:flutter_workout/service/add_senderName.dart';
import 'package:flutter_workout/service/confirm_notification.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('Users');

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
            'createdAt': FieldValue.serverTimestamp(),
          })
          .then((value) => print("Device Token SAVED!"))
          .catchError((error) => print("Failed to update user: $error"));
    }
  }

  //showDialog to ask workout
  Future requestDialog(RemoteMessage message) {
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
                //this function add the sender's(userA) name to the receiver's(userB) firestore database
                addSenderNameInReceiver(message.data["senderName"]);

                //this function add the receiver's(userB) name to the sender's(userA) firestore database
                addReceiverNameinSender(message.data["senderUid"]);

                //this function will send a HTTP post notification to sender(userA)
                sendConfirmNotification(message.data["senderUid"].toString());

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
    FriendsScreen(),
    WorkoutListScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _saveDeviceToken(_auth.currentUser.uid.toString());

    ////
    ///when app is opened show acceptDialog or requestDialog
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: $message");
      if (message.data['hasAccept'] == "true") {
        acceptDialog(message);
      } else {
        requestDialog(message);
      }
    });

    ////
    ///When app is NOT opened show acceptDialog or requestDialog in notification drawer
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //print('A new onMessageOpenedApp event was published!');
      print("onMessage: $message");
      requestDialog(message);
      if (message.data['hasAccept'] == "true") {
        acceptDialog(message);
      } else {
        requestDialog(message);
      }
    });
    print('homeScreen initstate has been called');
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
            icon: Icon(Icons.people_alt_outlined),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_kabaddi_sharp),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            // icon: Icon(Icons.bar_chart_sharp),
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
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
