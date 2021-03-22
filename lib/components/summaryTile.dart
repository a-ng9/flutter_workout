import 'package:flutter/material.dart';
import 'package:flutter_workout/const.dart';

class SummaryTile extends StatelessWidget {
  final String workoutTitle;
  final String timeNumReps;

  const SummaryTile({
    @required this.workoutTitle,
    @required this.timeNumReps,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(9))),
              //Container contents
              child: Padding(
                //inner padding for "title" and "picture"
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    //Header
                    Flexible(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Title
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              workoutTitle,
                              style:
                                  TextStyle(color: midNightBlue, fontSize: 20),
                            ),
                          ),
                          //Number of sets or Timer
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              timeNumReps,
                              style: TextStyle(
                                  color: midNightBlue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Space between to push picture to the complete right
                    Expanded(child: SizedBox()),
                    //Picture
                    Flexible(
                      flex: 2,
                      child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Image.asset('assets/images/Image.png')),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.20),
        ],
      ),
    );
  }
}
