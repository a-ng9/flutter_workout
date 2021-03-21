import 'package:flutter/material.dart';
import 'package:flutter_workout/components/reportContainer.dart';

import 'package:flutter_workout/const.dart';

class ReportScreen extends StatelessWidget {
  static const String id = 'reportScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: midNightBlue,
        elevation: 0,
        centerTitle: false,
        title: Text("Report"),
        actions: [IconButton(icon: Icon(Icons.person), onPressed: null)],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Today",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
            ),
            Row(
              children: [
                ReportContainer(
                  margin: const EdgeInsets.only(right: 7.0),
                  time: "30mins",
                  label: "Training Time",
                ),
                ReportContainer(
                  margin: const EdgeInsets.only(left: 7.0),
                  time: "2 times",
                  label: "Number of Exercise",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
