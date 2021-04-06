import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'package:flutter_workout/components/reportContainer.dart';
import 'package:flutter_workout/const.dart';
import 'package:flutter_workout/screens/logInUp_screen/login_screen.dart';

class ReportScreen extends StatefulWidget {
  static const String id = 'reportScreen';

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String displayUserName;
  String username;
  _currentUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      setState(() {
        displayUserName = auth.currentUser.displayName.toString();
      });
      print('display Name = ${auth.currentUser.displayName}');
    }
  }

  @override
  void initState() {
    _currentUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          children: [
            Text("$displayUserName"),

            // Text(
            //   "Today",
            //   style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
            // ),
            // Row(
            //   children: [
            //     ReportContainer(
            //       margin: const EdgeInsets.only(right: 7.0),
            //       time: "30mins",
            //       label: "Training Time",
            //     ),
            //     ReportContainer(
            //       margin: const EdgeInsets.only(left: 7.0),
            //       time: "2 times",
            //       label: "Number of Exercise",
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
