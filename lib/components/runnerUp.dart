import 'package:flutter/material.dart';
import 'package:flutter_workout/const.dart';

class RunnerUp extends StatelessWidget {
  const RunnerUp({this.name, this.score, this.colour, this.status});

  final String name;
  final String status;
  final int score;
  // final int rank;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(
        children: [
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width * 0.80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.horizontal(right: Radius.circular(9)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  //icon status
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Icon(Icons.circle, size: 12, color: colour),
                  ),
                  //name
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(color: darkBlack, fontSize: 20),
                      ),
                      // Text(
                      //   status,
                      //   style: TextStyle(color: colour),
                      // )
                    ],
                  ),
                  //expanded width
                  Expanded(child: SizedBox()),

                  Text(
                    "$score",
                    style: TextStyle(color: darkBlack, fontSize: 20),
                  )
                ],
              ),
            ),
          ),
          //Rank
          // Expanded(
          //   child: Center(
          //       child: Text(
          //     '#$rank',
          //     style: TextStyle(
          //         color: lightRed, fontSize: 24, fontWeight: FontWeight.w500),
          //   )),
          // ),
        ],
      ),
    );
  }
}
