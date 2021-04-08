import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_workout/const.dart';
import 'package:flutter_workout/components/buddyTile.dart';
import 'package:flutter_workout/components/roundedButton.dart';
import 'package:flutter_workout/helpers/user_status.dart';
import 'package:flutter_workout/screens/workingOut_screen.dart';

class AskBuddyScreen extends StatelessWidget {
  static const String id = "AskBuddy_Screen";

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
                    return Text("Loading");
                  }

                  return ListView(
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      return auth.currentUser.uid.toString() ==
                              document.data()['uid']
                          ? SizedBox.shrink()
                          : BuddyTile(
                              nameTitle: document.data()['display_name'],
                              colour: document.data()['presence'] == true
                                  ? Colors.green
                                  : Colors.grey[400]);
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
