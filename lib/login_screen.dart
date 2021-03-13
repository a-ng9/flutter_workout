import 'package:flutter/material.dart';

import 'package:flutter_workout/const.dart';
import 'package:flutter_workout/screens/home_screen.dart';
import 'package:flutter_workout/components/roundedButton.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'loginScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Stack(
          children: [
            ////Logo
            Center(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.width * 0.25),
                  Container(
                    height: 150,
                    width: 150,
                    color: lightRed,
                    child: Center(child: Text("Logo")),
                  ),
                ],
              ),
            ),
            ////TextFields
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 125),
                TextFormField(decoration: inputTextField),
                SizedBox(height: 8.0),
                TextFormField(
                  decoration: inputTextField.copyWith(
                      hintText: "Password",
                      prefixIcon:
                          Icon(Icons.lock_outline, color: Colors.white)),
                ),
              ],
            ),
            ////Login Button & Sign Up
            Column(
              children: [
                Expanded(child: SizedBox()),
                RoundedButton(
                    colour: lightRed,
                    text: 'Login',
                    pressed: () {
                      Navigator.pushReplacementNamed(context, HomeScreen.id);
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: lightRed),
                        ))
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
