import 'package:flutter/material.dart';
import 'package:flutter_workout/components/workoutContainersL.dart';
import 'package:flutter_workout/components/workoutContainersS.dart';
import 'package:flutter_workout/const.dart';
import 'package:flutter_workout/login_screen.dart';
import 'package:flutter_workout/screens/workoutDetail_screen.dart';

class WorkoutListScreen extends StatelessWidget {
  static const String id = 'workoutListScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: midNightBlue,
        elevation: 0,
        centerTitle: false,
        title: Text("Workout"),
        actions: [
          IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pushReplacementNamed(context, LoginScreen.id);
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              WorkoutContainerL(title: "Full Body"),
              WorkoutContainerL(title: "Upper Body"),
              WorkoutContainerL(title: "Lower Body"),

              //First row of boxes
              Row(
                children: [
////Abs Container (middle left container)
                  Expanded(
                      child: WorkoutContainerS(
                    title: "Abs",
                    margin: const EdgeInsets.only(right: 5, top: 5),
                  )),
////Chest Container (middle left container)
                  Expanded(
                      child: WorkoutContainerS(
                    title: "Chest",
                    margin: const EdgeInsets.only(left: 5, top: 5),
                  )),
                ],
              ),
              //Last row of boxes
              Row(
                children: [
                  //Shoulder/Back Container (bottom Right container)
                  Expanded(
                      child: WorkoutContainerS(
                    title: "Shoulder/Back",
                    margin: const EdgeInsets.only(right: 5, top: 10),
                    onPressed: () {
                      Navigator.pushNamed(context, WorkoutDetailScreen.id);
                    },
                  )),
//Legs Container (bottom Left container)
                  Expanded(
                      child: WorkoutContainerS(
                    title: "Legs",
                    margin: const EdgeInsets.only(left: 5, top: 10),
                    onPressed: () {
                      print("Button Pressed");
                    },
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: lightRed,
      //   child: Icon(
      //     Icons.directions_walk_sharp,
      //     color: Colors.white,
      //     size: 30,
      //   ),
      //   onPressed: () {},
      // ),
    );
  }
}
