import 'package:flutter/material.dart';

class RoundedButtonLogin extends StatelessWidget {
  const RoundedButtonLogin({
    @required this.colour,
    @required this.text,
    @required this.pressed,
  });

  final String text;
  final Function pressed;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.0,
      color: colour,
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        onPressed: pressed,
        minWidth: MediaQuery.of(context).size.width,
        height: 60.0,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
