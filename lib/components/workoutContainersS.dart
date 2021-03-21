import 'package:flutter/material.dart';
import 'package:flutter_workout/const.dart';

class WorkoutContainerS extends StatelessWidget {
  const WorkoutContainerS({
    this.title,
    this.margin,
    this.onPressed,
  });

  final String title;
  final EdgeInsets margin;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 150,
        margin: margin,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(9))),
        //Container content
        child: Column(
          children: [
            //Text
            Padding(
              padding: const EdgeInsets.all(7.0),
              child:
                  Text(title, style: TextStyle(color: darkBlack, fontSize: 23)),
            ),
            //Picture
            Image.asset("assets/images/Image.png")
          ],
        ),
      ),
    );
  }
}
