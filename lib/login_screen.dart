import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'loginScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Center(child: Text('This is the login screen'))],
      ),
    );
  }
}
