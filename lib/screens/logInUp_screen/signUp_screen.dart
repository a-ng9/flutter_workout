import 'package:flutter/material.dart';
import 'package:flutter_workout/components/roundedButtonLogin.dart';
import 'package:flutter_workout/const.dart';
import 'package:flutter_workout/screens/home_screen.dart';
import 'package:flutter_workout/service/database.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:firebase_auth/firebase_auth.dart';

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

  Future signUpAction() async {
    setState(() {
      showSpinner = true;
    });

    //////try method will try to make the user signup a new account with the below functions
    try {
      //matching inputControllers with firebaseAuth's parameters (email and password)
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      //updating & adding user's display name from FirebaseAuth
      User actualUser = FirebaseAuth.instance.currentUser;
      await actualUser.updateProfile(displayName: nameController.text);

      //saving the displayName, username and email to firestore database (service/database.dart)
      userSetup(
          nameController.text, usernameController.text, emailController.text);

      //Stop Showing spinner
      setState(() {
        showSpinner = false;
      });

      //when all of the above code has run, it is time to check if there is something is userCredential
      //If userCredential has some data, navigate user to home screen
      if (userCredential != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.id, (route) => false);
      }

      //////If any error occurs such as weak password, email already taken etc....
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: midNightBlue,
        elevation: 0,
        centerTitle: false,
        title: Text("Sign Up"),
        actions: [
          //back button to go back to login screen
          IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      //Modal that will show the spinner when showSpinner is true (from setStates in login function)
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
                  //
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
                  SizedBox(height: 8.0),

                  //TextInput for Email
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
              ////Sign Up button
              Column(
                children: [
                  Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: RoundedButtonLogin(
                        colour: lightRed,
                        text: 'Sign Up',
                        pressed: () {
                          signUpAction();
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
