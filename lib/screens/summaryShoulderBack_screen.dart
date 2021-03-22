import 'package:flutter/material.dart';

import 'package:flutter_workout/const.dart';
import 'package:flutter_workout/components/roundedButton.dart';
import 'package:flutter_workout/components/shoulderBackTile.dart';
import 'package:flutter_workout/screens/askBud_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class SummaryShoulderBackScreen extends StatelessWidget {
  static const String id = 'SummaryShoulderBackScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: midNightBlue, elevation: 0, centerTitle: false),
      body: FutureBuilder<Object>(
          future: FirebaseFirestore.instance.collection('ShoulderBack').get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //First 3 rows of information
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Wrap(runSpacing: 5, children: [
                    Text(
                      "Shoulder & Back",
                      style:
                          TextStyle(fontSize: 34, fontWeight: FontWeight.w500),
                    ),
                    Row(children: [
                      Icon(Icons.timer),
                      SizedBox(width: 5),
                      Text("12-15mins", style: TextStyle(fontSize: 18))
                    ]),
                    Row(children: [
                      Icon(Icons.accessibility),
                      SizedBox(width: 5),
                      Text("${snapshot.data.docs.length} workouts",
                          style: TextStyle(fontSize: 18))
                    ])
                  ]),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return ShoulderBackTile(
                            workoutTitle: snapshot.data.docs[index]['title'],
                            timeNumReps: snapshot.data.docs[index]['timereps']);
                      }),
                ),
                //Start Button
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: RoundedButton(
                        colour: lightRed,
                        text: "START",
                        pressed: () {
                          Navigator.pushNamed(context, AskBuddyScreen.id);
                        }),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
