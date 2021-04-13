import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_workout/const.dart';
import 'package:flutter_workout/components/runnerUp.dart';
import 'package:flutter_workout/helpers/get_userInfo.dart';
import 'package:flutter_workout/screens/friends_screens/searchFriend_screen.dart';

class FriendsScreen extends StatelessWidget {
  static const String id = 'friendScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: midNightBlue,
        elevation: 0,
        centerTitle: false,
        title: Text("Friends"),
        actions: [
          IconButton(
              icon: Icon(Icons.person_add),
              onPressed: () {
                Navigator.pushNamed(context, SearchFriend.id);
              })
        ],
      ),
      body: Column(
        children: [
          ////1st Rank
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Image.asset("assets/images/Trophie.png"),
                Positioned(
                  top: 25,
                  child: Text("100,000",
                      style: TextStyle(color: lightRed, fontSize: 24)),
                )
              ],
            ),
          ),
          Center(
            child: Text(
              "Charles Anderson",
              style: TextStyle(
                  color: lightRed, fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ),
          ////Runner ups widgets
          Expanded(
            //Using streamBuilder to get live information from firestore database
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
                  //Widget details is here
                  return ListView(
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      return auth.currentUser.uid.toString() ==
                              document.data()['uid']
                          ? SizedBox.shrink()
                          : RunnerUp(
                              status: document.data()['presence'] == true
                                  ? 'Online'
                                  : 'Offline',
                              colour: document.data()['presence'] == true
                                  ? Colors.green
                                  : Colors.grey[400],
                              name: document.data()['display_name'],
                              score: 0);
                    }).toList(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
