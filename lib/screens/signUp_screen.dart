import 'package:flutter/material.dart';
import 'package:flutter_workout/components/roundedButton.dart';
import 'package:flutter_workout/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_workout/login_screen.dart';
import 'package:flutter_workout/screens/home_screen.dart';
import 'package:flutter_workout/service/database.dart';

class SignUpScreen extends StatelessWidget {
  static const String id = 'signUpScreen';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 200),
                IconButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, LoginScreen.id);
                    },
                    icon: Icon(Icons.arrow_back_ios_outlined)),
                IconButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      print("User has been signed out");
                    },
                    icon: Icon(Icons.logout, color: Colors.red)),
              ],
            ),

            ////TextFields
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: inputTextField.copyWith(
                      hintText: "Name",
                      prefixIcon: Icon(Icons.person, color: Colors.white)),
                ),
                SizedBox(height: 8.0),
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
                    text: 'Sign Up',
                    pressed: () async {
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                        User updateUser = FirebaseAuth.instance.currentUser;
                        updateUser.updateProfile(
                            displayName: nameController.text);
                        userSetup(nameController.text);

                        print("USER CREATED ${userCredential.user}");

                        Navigator.pushReplacementNamed(context, HomeScreen.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
