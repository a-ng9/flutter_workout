import 'package:flutter/material.dart';

import 'package:flutter_workout/const.dart';
import 'package:flutter_workout/components/buddyTile.dart';
import 'package:flutter_workout/components/roundedButton.dart';
import 'package:flutter_workout/screens/workingOut_screen.dart';

class AskBuddyScreen extends StatelessWidget {
  static const String id = "AskBuddy_Screen";

  @override
  Widget build(BuildContext context) {
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
          Expanded(child: BuddyTile()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: RoundedButton(
                colour: lightRed,
                text: "START",
                pressed: () {
                  Navigator.pushNamed(context, WorkingOutScreen.id);
                }),
          ),
        ],
      ),
    );
  }
}
