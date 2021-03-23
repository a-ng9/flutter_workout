import 'package:flutter/material.dart';
import 'package:flutter_workout/const.dart';

class WorkoutContainerL extends StatelessWidget {
  const WorkoutContainerL({
    this.title,
    this.onPress,
  });

  final String title;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(9)),
        child: InkWell(
          splashColor: lightRed,
          onTap: onPress,
          child: Container(
            height: 130,
            width: double.infinity,
            //margin: const EdgeInsets.symmetric(vertical: 5.0),
            //Container contents
            child: Padding(
              //inner padding for "title" and "picture"
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  //Title
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text(
                        title,
                        style: TextStyle(color: midNightBlue, fontSize: 23),
                      ),
                    ),
                  ),
                  //Space between to push picture to the complete right
                  Expanded(
                    child: Container(
                      height: double.infinity,
                    ),
                  ),
                  //Picture
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset('assets/images/Image.png'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
