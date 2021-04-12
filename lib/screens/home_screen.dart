import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workout/screens/askBud_screen.dart';
import 'package:flutter_workout/screens/friends_screens/friends_screen.dart';
import 'package:flutter_workout/screens/report_screen.dart';
import 'package:flutter_workout/screens/workoutList_screen.dart';

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

  // StreamSubscription iosSubscription;

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
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: ListTile(
            title: Text(message.notification.title ?? 'null'),
            subtitle: Text(message.notification.body ?? 'null'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, AskBuddyScreen.id),
            ),
            TextButton(
              child: Text('No'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    });

    ///When app is not opened
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print("onMessage: $message");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: ListTile(
            title: Text(message.notification.title ?? 'Title is null'),
            subtitle: Text(message.notification.body ?? 'Body is null'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, AskBuddyScreen.id),
            ),
            TextButton(
              child: Text('No'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
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
