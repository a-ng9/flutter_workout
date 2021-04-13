import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_workout/const.dart';
import 'package:flutter_workout/components/buddyTile.dart';
import 'package:flutter_workout/components/roundedButton.dart';
import 'package:flutter_workout/helpers/get_userInfo.dart';
import 'package:flutter_workout/screens/workingOut_screen.dart';
import 'package:flutter_workout/service/requestBud_notification.dart';

class AskBuddyScreen extends StatefulWidget {
  static const String id = "AskBuddy_Screen";

  @override
  _AskBuddyScreenState createState() => _AskBuddyScreenState();
}

class _AskBuddyScreenState extends State<AskBuddyScreen> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    return Scaffold(
      appBar: AppBar(backgroundColor: midNightBlue, elevation: 0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //"Buddy" Text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "Buddy?",
              style: TextStyle(fontSize: 34),
            ),
          ),
          //Big Icon Buddy
          Center(child: Icon(Icons.people, size: 150, color: lightRed)),
          //Friends lists with a streamBuilder
          Expanded(
            //Using A streambuilder to get live data from firestore database
            child: StreamBuilder(
                stream: users.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  //Buddy Widget details
                  return ListView(
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      //A conditional to remove yourself from the list view
                      //if currentUser uid == snapshot.document.ui, show nothing(sizedBox), else show all users
                      return auth.currentUser.uid.toString() ==
                              document.data()['uid']
                          ? SizedBox.shrink()
                          : BuddyTile(
                              nameTitle: document.data()['display_name'],
                              onPressed: () async {
                                //This function will send a requestNotif to the respective bud
                                //uid here belongs to the receiver, needed to identify token device in firestore
                                requestBudNotif(
                                  document.data()['uid'].toString(),
                                );
                              },
                            );
                    }).toList(),
                  );
                }),
          ),
          //Start Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: RoundedButton(
              colour: lightRed,
              text: "START",
              pressed: () => Navigator.pushNamed(context, WorkingOutScreen.id),
            ),
          ),
        ],
      ),
    );
  }
}
