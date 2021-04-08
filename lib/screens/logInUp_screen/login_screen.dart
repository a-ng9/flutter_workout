import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_workout/helpers/user_status.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:flutter_workout/const.dart';
import 'package:flutter_workout/screens/home_screen.dart';
import 'package:flutter_workout/components/roundedButtonLogin.dart';
import 'package:flutter_workout/screens/logInUp_screen/signUp_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  InputDecoration emailTextFieldDeco;
  InputDecoration passwordTextFieldDeco;

  Future loginAction() async {
    setState(() {
      showSpinner = true;
    });
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      setState(() {
        showSpinner = false;
      });
      if (userCredential != null) {
        Navigator.pushReplacementNamed(context, HomeScreen.id);
        UserStatus.makeUserOnline(auth.currentUser.uid.toString());
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showSpinner = false;
      });
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        emailTextFieldDeco = emailTextFieldBad;
      } else if (e.code == 'invalid-email') {
        print("Invalid Email");
        emailTextFieldDeco = emailTextFieldBad;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        passwordTextFieldDeco = passwordTextFieldBad;
      } else if (e.code == 'is not true') {
        print('Missing Password');
        passwordTextFieldDeco = passwordTextFieldBad;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    emailTextFieldDeco = inputTextFieldDefault;
    passwordTextFieldDeco = inputTextFieldDefault.copyWith(
        hintText: "Password",
        prefixIcon: Icon(Icons.lock_outline, color: Colors.white));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: ModalProgressHUD(
          opacity: 0.01,
          inAsyncCall: showSpinner,
          child: Column(
            children: [
              //Logo
              Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: Image.asset("assets/images/Logo.png", scale: 2.5),
                  )),
              //TextField Inputs
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Column(
                  children: [
                    //Login TextField
                    TextFormField(
                      controller: emailController,
                      decoration: emailTextFieldDeco,
                      onChanged: (value) {
                        setState(() {
                          emailTextFieldDeco = inputTextFieldDefault;
                        });
                      },
                      validator: (value) => !value.contains('@')
                          ? 'please enter a valid email'
                          : null,
                    ),
                    SizedBox(height: 8.0),
                    //Password TextField
                    TextFormField(
                      controller: passwordController,
                      decoration: passwordTextFieldDeco,
                      onChanged: (value) {
                        setState(() {
                          passwordTextFieldDeco =
                              inputTextFieldDefault.copyWith(
                                  hintText: "Password",
                                  prefixIcon: Icon(Icons.lock_outline,
                                      color: Colors.white));
                        });
                      },
                      validator: (value) => value.length > 6
                          ? 'Must be atleast 6 characters'
                          : null,
                    ),
                  ],
                ),
              ),
              //Button & Sign Up
              Column(
                children: [
                  //Button
                  RoundedButtonLogin(
                      colour: lightRed,
                      text: 'Login',
                      pressed: () {
                        loginAction();
                      }),
                  //Sign up Text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, SignUpScreen.id);
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(color: lightRed),
                          ))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
