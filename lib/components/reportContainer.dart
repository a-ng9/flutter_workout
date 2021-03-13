import 'package:flutter/material.dart';

import 'package:flutter_workout/const.dart';

class ReportContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(15),
      height: 250,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(9))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Icon(
              Icons.timer,
              color: darkBlack,
              size: 35,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Text(
              "Training Time",
              style: TextStyle(fontSize: 20, color: darkBlack),
            ),
          ),
          Text(
            "30 mins",
            style: TextStyle(fontSize: 20, color: darkBlack),
          )
        ],
      ),
    );
  }
}
