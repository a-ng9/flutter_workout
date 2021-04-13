import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_workout/helpers/get_token.dart';
import 'package:flutter_workout/helpers/get_userInfo.dart';
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
    //////try method will try to make the user login with the below functions
    try {
      //Stop Showing spinner
      setState(() {
        showSpinner = false;
      });

      //matching inputControllers with firebaseAuth's parameters (email and password)
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      //Start Showing spinner
      setState(() {
        showSpinner = true;
      });

      //If userCredentials is filled with an account, make user online && Navigate to homeScreen
      if (userCredential != null) {
        await TokenInfo.deleteAllTokens();
        UserStatus.makeUserOnline(auth.currentUser.uid.toString());
        Navigator.pushReplacementNamed(context, HomeScreen.id);
      }

      //////If any error occurs such as password not match, user email invalid etc....
    } on FirebaseAuthException catch (e) {
      //Stop showing spinner
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

  //Setting the input decorations for the textfields with their apropriate colours and icons
  @override
  void initState() {
    super.initState();
    //Setting the input decorations for the textfields with their apropriate colours and icons
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
        //Modal that will show the spinner when showSpinner is true (from setStates in login function)
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
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Image.asset("assets/images/Logo.png", scale: 2.5),
                  )),
              //TextField Inputs
              Flexible(
                flex: 3,
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
                    // Expanded(child: SizedBox()),
                  ],
                ),
              ),
              //Button & Sign Up
              Flexible(
                flex: 2,
                fit: FlexFit.loose,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Login Button
                    RoundedButtonLogin(
                        colour: lightRed,
                        text: 'Login',
                        pressed: () {
                          loginAction();
                        }),
                    //Sign up Texts
                    Flexible(
                      flex: 2,
                      fit: FlexFit.loose,
                      child: Row(
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
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
