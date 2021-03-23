import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_workout/screens/summaryWorkouts/summaryShoulder_screen.dart';

class ShoulderStream extends StatefulWidget {
  final String type;
  ShoulderStream({this.type});

  @override
  _ShoulderStreamState createState() => _ShoulderStreamState();
}

class _ShoulderStreamState extends State<ShoulderStream> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('${widget.type}').get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {},
        );
      },
    );
  }
}
