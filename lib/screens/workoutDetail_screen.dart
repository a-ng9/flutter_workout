import 'package:flutter/material.dart';
import 'package:flutter_workout/components/workoutDetailContainer.dart';
import 'package:flutter_workout/components/roundedButton.dart';
import 'package:flutter_workout/data/exercises.dart';
import 'package:flutter_workout/const.dart';
import 'package:flutter_workout/screens/askBud_screen.dart';

class WorkoutDetailScreen extends StatefulWidget {
  static const String id = 'WorkoutDetailScreen';

  @override
  _WorkoutDetailScreenState createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  List<Exercises> workouts = [
    Exercises(titleExercise: 'Jumping Jacks', timeReps: '00:20'),
    Exercises(titleExercise: 'Push Up', timeReps: 'x10'),
    Exercises(titleExercise: 'Cat Cow Pose', timeReps: '00:30'),
    Exercises(titleExercise: 'Wide Push Up', timeReps: 'x5'),
    Exercises(titleExercise: 'Prone Tricep Push Up', timeReps: 'x14'),
    Exercises(titleExercise: 'Side Arm Raise', timeReps: '00:20'),
    Exercises(titleExercise: 'Arm Scissors', timeReps: '00:30'),
    Exercises(titleExercise: 'Push Up', timeReps: 'x10'),
    Exercises(titleExercise: 'Wide Push Up', timeReps: 'x5'),
    Exercises(titleExercise: 'Knee Push ups', timeReps: 'x5'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: midNightBlue, elevation: 0, centerTitle: false),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //First 3 rows of information
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Wrap(runSpacing: 5, children: [
                Text(
                  "Shoulder & Back",
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500),
                ),
                Row(children: [
                  Icon(Icons.timer),
                  SizedBox(width: 5),
                  Text("12-15mins", style: TextStyle(fontSize: 18))
                ]),
                Row(children: [
                  Icon(Icons.accessibility),
                  SizedBox(width: 5),
                  Text("${workouts.length} workouts",
                      style: TextStyle(fontSize: 18))
                ])
              ]),
            ),
            SizedBox(height: 10),

            //List of workouts
            Expanded(
              child: ListView.builder(
                itemCount: workouts.length,
                itemBuilder: (context, index) {
                  return WorkoutDetailContainer(
                      title: workouts[index].titleExercise,
                      timerReps: workouts[index].timeReps);
                },
              ),
            ),
            //Start Button
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: RoundedButton(
                    colour: lightRed,
                    text: "START",
                    pressed: () {
                      Navigator.pushNamed(context, AskBuddyScreen.id);
                    }),
              ),
            ),
          ],
        ));
  }
}
