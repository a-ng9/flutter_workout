import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:flutter_workout/components/reportContainer.dart';
import 'package:flutter_workout/const.dart';
import 'package:flutter_workout/helpers/user_status.dart';
import 'package:flutter_workout/model/user.dart';
import 'package:flutter_workout/screens/logInUp_screen/login_screen.dart';
import 'package:flutter_workout/service/database.dart';

class ReportScreen extends StatefulWidget {
  static const String id = 'reportScreen';

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String displayName;
  String username;
  UserModel currentUser;

  _fetchUserDetails() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser.uid.toString();
    DocumentSnapshot doc = await usersRef.doc(uid).get();

    currentUser = UserModel.fromDocument(doc);

    if (auth.currentUser != null) {
      setState(() {
        displayName = auth.currentUser.displayName.toString();
        username = UserModel.fromDocument(doc).username.toString();
      });
      // print('display Name = ${auth.currentUser.displayName}');
      // print('my username is = $username');
    }
  }

  @override
  void initState() {
    _fetchUserDetails();
    super.initState();
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
        title: Text("Report"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              UserStatus.makeUserOffline(auth.currentUser.uid.toString());
              await FirebaseAuth.instance.signOut();

              Navigator.pushReplacementNamed(context, LoginScreen.id);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text("$displayName"), Text('username: $username')],
        ),
      ),
    );
  }
}
