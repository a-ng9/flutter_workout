import 'package:flutter/material.dart';

////////Colours
///Main Colours
const midNightBlue = const Color(0xFF384059);
const darkBlack = const Color(0xFF262A37);
const lightRed = const Color(0xFFD65852);

//////TextFormField
///login
const inputTextField = InputDecoration(
  prefixIcon: Icon(Icons.person_outline, color: Colors.white),
  hintText: "Email",
  //hintStyle: TextStyle(color: Colors.white),
  filled: true,
  fillColor: darkBlack,
  border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide.none),
);
