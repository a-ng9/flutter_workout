import 'package:flutter/material.dart';

import 'package:flutter_workout/const.dart';
import 'package:flutter_workout/helpers/get_token.dart';
import 'package:flutter_workout/screens/friends_screens/searchFriend_screen.dart';
import 'package:flutter_workout/screens/logInUp_screen/login_screen.dart';
import 'package:flutter_workout/screens/finish_screen.dart';
import 'package:flutter_workout/screens/logInUp_screen/signUp_screen.dart';
import 'package:flutter_workout/screens/askBud_screen.dart';
import 'package:flutter_workout/screens/home_screen.dart';
import 'package:flutter_workout/screens/summaryWorkouts/summaryAbs_screen.dart';
import 'package:flutter_workout/screens/summaryWorkouts/summaryChest_screen.dart';
import 'package:flutter_workout/screens/summaryWorkouts/summaryFullBody_screen.dart';
import 'package:flutter_workout/screens/summaryWorkouts/summaryLegs_screen.dart';
import 'package:flutter_workout/screens/summaryWorkouts/summaryLowerBody_screen.dart';
import 'package:flutter_workout/screens/summaryWorkouts/summaryShoulderBack_screen.dart';
import 'package:flutter_workout/screens/summaryWorkouts/summaryUpperBody_screen.dart';
import 'package:flutter_workout/screens/workingOut_screen.dart';
import 'package:flutter_workout/screens/workoutList_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference users = FirebaseFirestore.instance.collection('Users');

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  String uid;

  Future<void> getUserid() async {
    setState(() {
      try {
        uid = auth.currentUser.uid.toString();
      } catch (err) {
        print(err);
      }
    });
  }

  Future<void> makeUserOnline() {
    return users
        .doc(uid)
        .update({'presence': true})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> makeUserOffline() {
    return users
        .doc(uid)
        .update({'presence': false})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getUserid();
    if (uid != null) {
      makeUserOnline();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    getUserid();
    print(state);
    // final isBackground = state == AppLifecycleState.paused;

    if (state == AppLifecycleState.paused) {
      if (uid != null) {
        makeUserOffline();
      }
    } else if (state == AppLifecycleState.resumed) {
      if (uid != null) {
        makeUserOnline();
        TokenInfo.getToken(uid);
      }
    } else if (state == AppLifecycleState.inactive) {
      if (uid != null) {
        makeUserOffline();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    User firebaseUser = FirebaseAuth.instance.currentUser;
    String screenRoute;

    if (firebaseUser != null) {
      screenRoute = HomeScreen.id;
    } else {
      screenRoute = LoginScreen.id;
      print("User not logged in");
    }
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Montserrat'),
          appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                  headline6: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 50,
                      fontWeight: FontWeight.w700))),
          accentColor: lightRed,
          scaffoldBackgroundColor: midNightBlue,
        ),
        initialRoute: screenRoute,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          WorkoutListScreen.id: (context) => WorkoutListScreen(),
          SummaryFullScreen.id: (context) => SummaryFullScreen(),
          SummaryUpperScreen.id: (context) => SummaryUpperScreen(),
          SummaryLowerScreen.id: (context) => SummaryLowerScreen(),
          SummaryChestScreen.id: (context) => SummaryChestScreen(),
          SummaryAbsScreen.id: (context) => SummaryAbsScreen(),
          SummaryLegsScreen.id: (context) => SummaryLegsScreen(),
          SummaryShoulderBackScreen.id: (context) =>
              SummaryShoulderBackScreen(),
          AskBuddyScreen.id: (context) => AskBuddyScreen(),
          WorkingOutScreen.id: (context) => WorkingOutScreen(),
          FinishScreen.id: (context) => FinishScreen(),
          SearchFriend.id: (context) => SearchFriend(),
        });
  }
}
