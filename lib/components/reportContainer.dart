import 'package:flutter/material.dart';

import 'package:flutter_workout/const.dart';

class ReportContainer extends StatelessWidget {
  const ReportContainer({Key key, this.margin, this.label, this.time})
      : super(key: key);

  final EdgeInsets margin;
  final String label;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: margin,
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
                label,
                style: TextStyle(fontSize: 20, color: darkBlack),
              ),
            ),
            Row(
              children: [
                Text(time,
                    style: TextStyle(
                        fontSize: 20,
                        color: darkBlack,
                        fontWeight: FontWeight.w600)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
