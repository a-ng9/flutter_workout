import 'package:flutter/material.dart';

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
    );
  }
}
