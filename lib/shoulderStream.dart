// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_workout/const.dart';
// import 'package:flutter_workout/screens/summaryShoulder_screen.dart';

// class ShoulderStream extends StatefulWidget {
//   final String type;
//   ShoulderStream({this.type});

//   @override
//   _ShoulderStreamState createState() => _ShoulderStreamState();
// }

// class _ShoulderStreamState extends State<ShoulderStream> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: FirebaseFirestore.instance.collection('${widget.type}').get(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (!snapshot.hasData) {
//           return Center(child: CircularProgressIndicator());
//         }

//         return ListView.builder(
//           itemCount: snapshot.data.docs.length,
//           itemBuilder: (context, index) {
//             SummaryShoulderScreen.of(context).setNum =
//                 snapshot.data.docs.length;

//             return Padding(
//               padding: const EdgeInsets.only(bottom: 10),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       height: 120,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.horizontal(
//                               right: Radius.circular(9))),
//                       //Container contents
//                       child: Padding(
//                         //inner padding for "title" and "picture"
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           children: [
//                             //Header
//                             Flexible(
//                               flex: 3,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   //Title
//                                   Align(
//                                     alignment: Alignment.topLeft,
//                                     child: Text(
//                                       snapshot.data.docs[index]['title'],
//                                       style: TextStyle(
//                                           color: midNightBlue, fontSize: 20),
//                                     ),
//                                   ),
//                                   //Number of sets or Timer
//                                   Align(
//                                     alignment: Alignment.topLeft,
//                                     child: Text(
//                                       snapshot.data.docs[index]['timereps'],
//                                       style: TextStyle(
//                                           color: midNightBlue,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w300),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             //Space between to push picture to the complete right
//                             Expanded(child: SizedBox()),
//                             //Picture
//                             Flexible(
//                               flex: 2,
//                               child: Padding(
//                                   padding: const EdgeInsets.only(right: 20),
//                                   child:
//                                       Image.asset('assets/images/Image.png')),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: MediaQuery.of(context).size.width * 0.20),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
