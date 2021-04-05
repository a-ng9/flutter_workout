import 'package:flutter/material.dart';
import 'package:flutter_workout/components/roundedButtonLogin.dart';
import 'package:flutter_workout/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_workout/login_screen.dart';
import 'package:flutter_workout/screens/home_screen.dart';
// import 'package:flutter_workout/service/database.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'signUpScreen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future signUpAction() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      User updateUser = FirebaseAuth.instance.currentUser;
      await updateUser.updateProfile(displayName: nameController.text);

      print('Name is: ${userCredential.user.displayName}');
      print('Email is: ${userCredential.user.email}');
      //
      //
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: midNightBlue,
        elevation: 0,
        centerTitle: false,
        title: Text("Sign Up"),
        actions: [
          IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Stack(
          children: [
            ////TextFields
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: inputTextFieldDefault.copyWith(
                      hintText: "Name",
                      prefixIcon: Icon(Icons.person, color: Colors.white)),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: emailController,
                  decoration: inputTextFieldDefault,
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: passwordController,
                  decoration: inputTextFieldDefault.copyWith(
                      hintText: "Password",
                      prefixIcon:
                          Icon(Icons.lock_outline, color: Colors.white)),
                ),
              ],
            ),
            ////Sign Up
            Column(
              children: [
                Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: RoundedButtonLogin(
                      colour: lightRed,
                      text: 'Sign Up',
                      pressed: () async {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            });

                        await signUpAction();
                        Navigator.pushNamedAndRemoveUntil(
                            context, HomeScreen.id, (route) => false);
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
