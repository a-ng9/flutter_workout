import 'package:flutter/material.dart';
import 'package:flutter_workout/components/roundedButtonLogin.dart';
import 'package:flutter_workout/const.dart';
import 'package:flutter_workout/screens/home_screen.dart';
import 'package:flutter_workout/service/database.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'signUpScreen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool showSpinner = false;
  String username;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  InputDecoration emailTextFieldDeco;
  InputDecoration passwordTextFieldDeco;
  CollectionReference users = FirebaseFirestore.instance.collection("Users");

  Future signUpAction() async {
    setState(() {
      showSpinner = true;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      User updateUser = FirebaseAuth.instance.currentUser;

      await updateUser.updateProfile(displayName: nameController.text);
      userSetup(
          nameController.text, usernameController.text, emailController.text);

      // print('Name is: ${userCredential.user.displayName}');
      // print('Email is: ${userCredential.user.email}');

      if (userCredential != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.id, (route) => false);
      }
      setState(() {
        showSpinner = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        showSpinner = false;
      });
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        setState(() {
          passwordTextFieldDeco = passwordTextFieldBad;
        });
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        setState(() {
          emailTextFieldDeco = emailTextFieldBad;
        });
      } else if (e.code == 'invalid-email') {
        print("Invalid Email");
        setState(() {
          showSpinner = false;
        });
      }
    } catch (e) {
      print(e);
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
      body: ModalProgressHUD(
        opacity: 0.01,
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Stack(
            children: [
              ////TextFields
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //TextInput for Name
                  TextFormField(
                    controller: nameController,
                    decoration: inputTextFieldDefault.copyWith(
                        hintText: "Name",
                        prefixIcon: Icon(Icons.person, color: Colors.white)),
                  ),
                  SizedBox(height: 8.0),
                  //TextInput for Username
                  TextFormField(
                    validator: (val) {
                      if (val.trim().length < 3 || val.isEmpty) {
                        return "Username is too short, should be between 3 to 12 characters";
                      } else if (val.trim().length > 12) {
                        return "Username is too long, should be between 3 to 12 characters";
                      } else
                        return null;
                    },
                    controller: usernameController,
                    decoration: inputTextFieldDefault.copyWith(
                        hintText: "Userame",
                        prefixIcon: Icon(Icons.account_box_rounded,
                            color: Colors.white)),
                  ),
                  //TextInput for Email
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: emailController,
                    decoration: inputTextFieldDefault,
                    validator: (value) => !value.contains('@')
                        ? 'please enter a valid email'
                        : null,
                  ),
                  SizedBox(height: 8.0),
                  // TextInput for Password
                  TextFormField(
                    controller: passwordController,
                    decoration: inputTextFieldDefault.copyWith(
                        hintText: "Password",
                        prefixIcon:
                            Icon(Icons.lock_outline, color: Colors.white)),
                    validator: (value) => value.length > 6
                        ? 'Must be atleast 6 characters'
                        : null,
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
                        pressed: () {
                          // showDialog(
                          //     context: context,
                          //     builder: (BuildContext context) {
                          //       return Center(
                          //         child: CircularProgressIndicator(),
                          //       );
                          //     });

                          signUpAction();
                          // Navigator.pushNamedAndRemoveUntil(
                          //     context, HomeScreen.id, (route) => false);
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
