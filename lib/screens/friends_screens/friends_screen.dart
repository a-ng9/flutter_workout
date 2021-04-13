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
            padding: const EdgeInsets.only(
              top: 20.0,
            ),
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Image.asset("assets/images/Trophie.png"),
                Positioned(
                  top: 25,
                  child: Text("100,000",
                      style: TextStyle(color: Colors.white, fontSize: 24)),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: const Radius.circular(15),
              ),
            ),
            child: Text(
              "Charles Anderson",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
          ),
          ////Runner ups widgets
          Expanded(
            //Using streamBuilder to get live information from firestore database
            child: StreamBuilder(
                stream: users.orderBy('points', descending: true).snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  /////Widget details is here
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return auth.currentUser.uid.toString() ==
                                snapshot.data.docs[index]['uid']
                            ? RunnerUp(
                                rank: (index + 2).toString(),
                                status: '',
                                iconColour: Colors.white,
                                name: snapshot.data.docs[index]['display_name'],
                                fontWeight: FontWeight.w700,
                                score: snapshot.data.docs[index]['points'])
                            : RunnerUp(
                                status: snapshot.data.docs[index]['presence'] ==
                                        true
                                    ? 'Online'
                                    : 'Offline',
                                iconColour: snapshot.data.docs[index]
                                            ['presence'] ==
                                        true
                                    ? Colors.green
                                    : Colors.grey[400],
                                rank: (index + 2).toString(),
                                name: snapshot.data.docs[index]['display_name'],
                                fontWeight: FontWeight.normal,
                                score: snapshot.data.docs[index]['points']);
                      });
                }),
          ),
        ],
      ),
    );
  }
}
