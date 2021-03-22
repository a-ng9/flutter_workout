import 'package:flutter/material.dart';

import 'package:flutter_workout/const.dart';
import 'package:flutter_workout/login_screen.dart';
import 'package:flutter_workout/screens/askBud_screen.dart';
import 'package:flutter_workout/screens/home_screen.dart';
import 'package:flutter_workout/screens/summaryLegs_screen.dart';
import 'package:flutter_workout/screens/summaryShoulderBack_screen.dart';
import 'package:flutter_workout/screens/summaryShoulder_screen.dart';
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
          SummaryShoulderBackScreen.id: (context) =>
              SummaryShoulderBackScreen(),
          SummaryLegsScreen.id: (context) => SummaryLegsScreen(),
          AskBuddyScreen.id: (context) => AskBuddyScreen(),
        });
  }
}
