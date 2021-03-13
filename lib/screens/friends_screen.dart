import 'package:flutter/material.dart';
import 'package:flutter_workout/components/runnerUp.dart';

import 'package:flutter_workout/const.dart';

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
        actions: [IconButton(icon: Icon(Icons.person), onPressed: null)],
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
          ////Runner Ups
          RunnerUp(rank: 2, name: "John Doe", score: 1000),
          RunnerUp(rank: 3, name: "James Smith", score: 800),
          RunnerUp(rank: 4, name: "Peter Miller", score: 500),
        ],
      ),
    );
  }
}
