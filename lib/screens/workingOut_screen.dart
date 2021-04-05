import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_workout/const.dart';
import 'package:flutter_workout/screens/finish_screen.dart';

class WorkingOutScreen extends StatelessWidget {
  static const String id = "WorkingOut Screen";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: darkBlack),
        ),
        body: Column(
          children: [
            //Picture/Gif in white space
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.white,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.bottomRight,
                  //Info Icon
                  child: IconButton(
                    icon: Icon(
                      Icons.info_outline,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            //Exercise Title
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  "Jumping Jacks",
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            //Time or reps info
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  "00:20",
                  style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            //Action buttons
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Back Button
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_sharp,
                        color: lightRed,
                      ),
                      onPressed: () {}),
                  //Pause/Play Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: RawMaterialButton(
                      elevation: 0,
                      fillColor: lightRed,
                      child: Icon(Icons.pause, size: 40),
                      shape: CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      onPressed: () {},
                    ),
                  ),
                  //Forward Button
                  IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: lightRed,
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, FinishScreen.id);
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
