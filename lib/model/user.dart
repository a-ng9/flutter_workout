import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  @required
  final String uid;
  @required
  final String username;
  @required
  final String displayName;
  @required
  final String email;

  UserModel({
    this.uid,
    this.username,
    this.displayName,
    this.email,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      uid: doc['uid'],
      username: doc['username'],
      displayName: doc['display_name'],
      email: doc['email'],
    );
  }
}
