import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_workout/const.dart';
import 'package:flutter_workout/screens/finish_screen.dart';

class WorkingOutScreen extends StatefulWidget {
  static const String id = "WorkingOut Screen";

  @override
  _WorkingOutScreenState createState() => _WorkingOutScreenState();
}

class _WorkingOutScreenState extends State<WorkingOutScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> removeBuddy() {
    return users
        .doc(auth.currentUser.uid.toString())
        .update({'buddy': ''})
        .then((value) => print("Removed Buddy"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    Stream documentStream = FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser.uid.toString())
        .snapshots();

    return SafeArea(
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
              removeBuddy();
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: darkBlack),
        ),
        body: Column(
          children: [
            //Picture/Gif in white space
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.white,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.bottomRight,
                  //Info Icon
                  child: IconButton(
                    icon: Icon(
                      Icons.info_outline,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            //Exercise Title
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Buddy Name
                  StreamBuilder<DocumentSnapshot>(
                    stream: documentStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('No Buddy');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }
                      String buddyName = snapshot.data['buddy'].toString();

                      //if there is no buddy, display No Buddy
                      if (snapshot.data['buddy'].toString().isEmpty) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              (Icons.circle),
                              size: 12,
                              color: Colors.grey[400],
                            ),
                            SizedBox(width: 5),
                            Text("No Buddy",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        );
                      }
                      //if there is a buddy, display his/her name
                      if (buddyName.isNotEmpty) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              (Icons.circle),
                              size: 12,
                              color: Colors.green,
                            ),
                            SizedBox(width: 5),
                            Text(buddyName,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        );
                      } else
                        return Text('No Buddy');
                    },
                  ),
                  Text(
                    "Jumping Jacks",
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            //Time or reps info
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  "00:20",
                  style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            //Action buttons
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Back Button
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_sharp,
                        color: lightRed,
                      ),
                      onPressed: () {}),
                  //Pause/Play Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: RawMaterialButton(
                      elevation: 0,
                      fillColor: lightRed,
                      child: Icon(Icons.pause, size: 40),
                      shape: CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      onPressed: () {},
                    ),
                  ),
                  //Forward Button
                  IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: lightRed,
                      ),
                      onPressed: () {
                        removeBuddy();
                        Navigator.pushReplacementNamed(
                            context, FinishScreen.id);
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
