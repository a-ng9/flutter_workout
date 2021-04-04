import 'package:flutter/material.dart';

////////Colours
///Main Colours
const midNightBlue = const Color(0xFF384059);
const darkBlack = const Color(0xFF262A37);
const lightRed = const Color(0xFFD65852);

//////TextFormField
///login decoration
const inputTextFieldDefault = InputDecoration(
  prefixIcon: Icon(Icons.person_outline, color: Colors.white),
  hintText: "Email",
  filled: true,
  fillColor: darkBlack,
  border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide.none),
);

const emailTextFieldBad = InputDecoration(
  prefixIcon: Icon(Icons.person_outline, color: Colors.red),
  hintText: "Email",
  filled: true,
  fillColor: darkBlack,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(color: Colors.redAccent)),
);

const passwordTextFieldBad = InputDecoration(
  prefixIcon: Icon(Icons.lock_outline, color: Colors.red),
  hintText: "Password",
  filled: true,
  fillColor: darkBlack,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(color: Colors.redAccent)),
);
