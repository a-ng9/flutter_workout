import 'package:flutter/material.dart';

import 'package:flutter_workout/const.dart';
import 'package:flutter_workout/login_screen.dart';
import 'package:flutter_workout/screens/askBud_screen.dart';
import 'package:flutter_workout/screens/home_screen.dart';
import 'package:flutter_workout/screens/summaryWorkouts/summaryAbs_screen.dart';
import 'package:flutter_workout/screens/summaryWorkouts/summaryChest_screen.dart';
import 'package:flutter_workout/screens/summaryWorkouts/summaryFullBody_screen.dart';
import 'package:flutter_workout/screens/summaryWorkouts/summaryLegs_screen.dart';
import 'package:flutter_workout/screens/summaryWorkouts/summaryLowerBody_screen.dart';
import 'package:flutter_workout/screens/summaryWorkouts/summaryShoulderBack_screen.dart';
import 'package:flutter_workout/screens/summaryWorkouts/summaryUpperBody_screen.dart';
//import 'package:flutter_workout/screens/summaryWorkouts/summaryShoulder_screen.dart';
import 'package:flutter_workout/screens/workoutList_screen.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
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
        });
  }
}
