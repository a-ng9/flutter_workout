import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_workout/const.dart';
import 'package:flutter_workout/screens/home_screen.dart';

import 'package:confetti/confetti.dart';

class FinishScreen extends StatefulWidget {
  static const String id = "Finish Screen";

  @override
  _FinishScreenState createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  ConfettiController controller;

  @override
  void initState() {
    super.initState();
    controller = ConfettiController(duration: Duration(seconds: 2));
    controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: midNightBlue,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            size: 30,
          ),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.id, (route) => false);
          },
        ),
      ),
      body: Column(
        children: [
          //Stars and Congrats
          Flexible(
            flex: 3,
            child: Column(
              children: [
                //Three stars
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: lightRed, size: 50),
                    Icon(Icons.star_outline, color: lightRed, size: 100),
                    Icon(Icons.star, color: lightRed, size: 50),
                  ],
                ),
                //Text "Congratulations"
                Text("Congratulations!", style: TextStyle(fontSize: 35)),
                //Double red lines below Congrats
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                        flex: 4,
                        child: Container(height: 1.5, color: lightRed),
                      ),
                      Expanded(flex: 2, child: SizedBox()),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Expanded(flex: 2, child: SizedBox()),
                      Expanded(
                        flex: 4,
                        child: Container(height: 1.5, color: lightRed),
                      ),
                      Expanded(flex: 1, child: SizedBox()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ConfettiWidget(
            particleDrag: 0.03,
            confettiController: controller,
            emissionFrequency: 0,
            blastDirection: -pi / 2,
            minBlastForce: 0.1,
            maxBlastForce: 2,
            numberOfParticles: 50,
            colors: [Colors.yellow, Colors.red, Colors.blue, Colors.green],
          ),
          //Texts "Points Earned"
          Flexible(
            flex: 4,
            child: Column(
              children: [
                Text("1000",
                    style:
                        TextStyle(fontSize: 60, fontWeight: FontWeight.bold)),
                Text("Points Earned",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
              ],
            ),
          ),
          //3 Texts of Detailed achievements
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Num of Workouts
                Column(children: [
                  Text("14",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  Text("Workouts")
                ]),
                //Num of Points
                Column(children: [
                  Text("1000",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  Text("Points")
                ]),
                //Partner Multiplier
                Column(children: [
                  Text("1",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  Text("Partner"),
                  Text("Multiplier")
                ])
              ],
            ),
          ),
          //Button Check
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: RawMaterialButton(
                elevation: 0,
                fillColor: lightRed,
                child: Icon(Icons.check, size: 40),
                shape: CircleBorder(),
                padding: const EdgeInsets.all(20),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeScreen.id, (route) => false);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
