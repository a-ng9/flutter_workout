import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_workout/const.dart';
import 'package:flutter_workout/screens/home_screen.dart';
import 'package:flutter_workout/components/roundedButton.dart';
import 'package:flutter_workout/screens/signUp_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'loginScreen';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Stack(
          children: [
            ////Logo
            Column(
              children: [
                Container(height: MediaQuery.of(context).size.height * 0.1),
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset("assets/images/Logo.png", scale: 2.5),
                ),
              ],
            ),
            ////TextFields
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: inputTextField,
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: passwordController,
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
                    pressed: () async {
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                        print(userCredential);
                        Navigator.pushReplacementNamed(context, HomeScreen.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      }

                      // context.read<AuthenticationService>().signOut();
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushReplacementNamed(
                              context, SignUpScreen.id);
                        },
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
