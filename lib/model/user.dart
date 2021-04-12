import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  final String uid;
  final String username;
  final String displayName;
  final String email;
  bool presence;
  final String buddy;

  UserModel({
    @required this.uid,
    @required this.username,
    @required this.displayName,
    @required this.email,
    @required this.presence,
    this.buddy,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
        uid: doc['uid'],
        username: doc['username'],
        displayName: doc['display_name'],
        email: doc['email'],
        presence: doc['presence'],
        buddy: doc['buddy']);
  }
}
