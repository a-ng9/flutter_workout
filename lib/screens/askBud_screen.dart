import 'package:flutter/material.dart';
import 'package:flutter_workout/const.dart';

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
          Center(child: Icon(Icons.people, size: 150)),
        ],
      ),
    );
  }
}
