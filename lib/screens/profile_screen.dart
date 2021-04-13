import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_workout/const.dart';
import 'package:flutter_workout/helpers/get_token.dart';
import 'package:flutter_workout/helpers/get_userInfo.dart';
import 'package:flutter_workout/model/user.dart';
import 'package:flutter_workout/screens/logInUp_screen/login_screen.dart';
import 'package:flutter_workout/service/database.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'reportScreen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String displayName;
  String username;
  String email;
  UserModel currentUser;

  _fetchUserDetails() async {
    DocumentSnapshot doc = await usersRef.doc(uid).get();

    currentUser = UserModel.fromDocument(doc);

    if (auth.currentUser != null) {
      setState(() {
        displayName = auth.currentUser.displayName.toString();
        username = UserModel.fromDocument(doc).username.toString();
        email = UserModel.fromDocument(doc).email.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: midNightBlue,
        elevation: 0,
        centerTitle: false,
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              //dialog to confirm if user wants to sign out
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: ListTile(
                    title: Text("Sign Out"),
                    subtitle: Text('Are you sure you want to sign out?'),
                  ),
                  actions: <Widget>[
                    //If yes: remove token, user offline, naviagte to loginScreen
                    TextButton(
                      child: Text('Yes'),
                      onPressed: () async {
                        await TokenInfo.deleteToken();
                        UserStatus.makeUserOffline(
                            auth.currentUser.uid.toString());
                        await FirebaseAuth.instance.signOut();

                        Navigator.pushNamedAndRemoveUntil(
                            context, LoginScreen.id, (route) => false);
                      },
                    ),
                    //if no, just pop showDialog
                    TextButton(
                      child: Text('No'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 14.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.self_improvement_rounded,
                  size: 120,
                  color: lightRed,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: const Radius.circular(15),
                    ),
                  ),
                  child: Text(
                    displayName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                      Text(
                        email,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "username",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                      Text(
                        username,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
