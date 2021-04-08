import 'package:flutter/material.dart';
import 'package:flutter_workout/screens/friends_screens/friends_screen.dart';
import 'package:flutter_workout/screens/report_screen.dart';
import 'package:flutter_workout/screens/workoutList_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedScreen = 1;
  // String _uid;
  // FirebaseAuth _auth = FirebaseAuth.instance;

  final _screenOptions = [
    ReportScreen(),
    WorkoutListScreen(),
    FriendsScreen(),
  ];

  // Future<void> getUserid() async {
  //   setState(() {
  //     try {
  //       _uid = _auth.currentUser.uid.toString();
  //     } catch (err) {
  //       print(err);
  //     }
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();

  //   getUserid().then((_) {
  //     UserStatus.makeUserOnline(_uid);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screenOptions[_selectedScreen],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreen,
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(size: 30),
        items: [
          BottomNavigationBarItem(
            // icon: Icon(Icons.bar_chart_sharp),
            icon: Icon(Icons.account_circle_outlined),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_kabaddi_sharp),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined),
            label: 'Friends',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedScreen = index;
          });
        },
      ),
    );
  }
}
