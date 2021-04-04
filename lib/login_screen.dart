import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_workout/screens/signUp_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:flutter_workout/const.dart';
import 'package:flutter_workout/screens/home_screen.dart';
import 'package:flutter_workout/components/roundedButton.dart';

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
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0),
                    child: Image.asset("assets/images/Logo.png", scale: 2.5),
                  )),
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
                          passwordTextFieldDeco = inputTextFieldDefault;
                        });
                      },
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
                    ),
                  ],
                ),
              ),
              //Expanded(child: SizedBox()),
              Column(
                children: [
                  RoundedButton(
                      colour: lightRed,
                      text: 'Login',
                      pressed: () {
                        loginAction();
                        // Navigator.pushNamedAndRemoveUntil(
                        //     context, HomeScreen.id, (route) => false);
                      }),
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
