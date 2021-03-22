// import 'package:flutter/material.dart';
// import 'package:flutter_workout/components/roundedButton.dart';
// import 'package:flutter_workout/const.dart';
// import 'package:flutter_workout/screens/askBud_screen.dart';

// class SummaryShoulderScreen extends StatefulWidget {
//   static const String id = 'SummaryShoulderScreen';

//   @override
//   _SummaryShoulderScreenState createState() => _SummaryShoulderScreenState();

//   static _SummaryShoulderScreenState of(BuildContext context) =>
//       context.findAncestorStateOfType<_SummaryShoulderScreenState>();
// }

// class _SummaryShoulderScreenState extends State<SummaryShoulderScreen> {
//   int _worknum = 0;

//   set setNum(int value) {
//     Future.delayed(Duration.zero, () async {
//       if (mounted) {
//         setState(() => _worknum = value);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//             backgroundColor: midNightBlue, elevation: 0, centerTitle: false),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             //First 3 rows of information
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10.0),
//               child: Wrap(runSpacing: 5, children: [
//                 Text(
//                   "Shoulder & Back",
//                   style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500),
//                 ),
//                 Row(children: [
//                   Icon(Icons.timer),
//                   SizedBox(width: 5),
//                   Text("12-15mins", style: TextStyle(fontSize: 18))
//                 ]),
//                 Row(children: [
//                   Icon(Icons.accessibility),
//                   SizedBox(width: 5),
//                   Text("$_worknum workouts")
//                 ])
//               ]),
//             ),
//             SizedBox(height: 10),
//             // Expanded(
//             //   child: ShoulderStream(
//             //     type: 'ShoulderBack',
//             //   ),
//             // ),
//             //Start Button
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: RoundedButton(
//                     colour: lightRed,
//                     text: "START",
//                     pressed: () {
//                       Navigator.pushNamed(context, AskBuddyScreen.id);
//                     }),
//               ),
//             ),
//           ],
//         ));
//   }
// }
