import 'package:flutter/material.dart';
import 'package:flutter_workout/const.dart';

class BuddyTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          width: MediaQuery.of(context).size.width * 0.80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.horizontal(right: Radius.circular(9)),
          ),
          child: Text("name",
              style: TextStyle(
                color: darkBlack,
                fontSize: 20,
              )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.5),
          child: Row(
            children: [
              SizedBox(width: (MediaQuery.of(context).size.width * 0.80) - 25),
              ClipOval(
                child: Material(
                  color: lightRed, // button color
                  child: InkWell(
                    splashColor: Colors.black, // inkwell color
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Icon(Icons.send_outlined)),
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
