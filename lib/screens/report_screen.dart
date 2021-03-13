import 'package:flutter/material.dart';

import 'package:flutter_workout/const.dart';
import 'package:flutter_workout/login_screen.dart';

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
    );
  }
}
