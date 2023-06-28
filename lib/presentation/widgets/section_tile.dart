import 'package:flutter/material.dart';

class SectionTile extends StatelessWidget {
  String title;
  IconData icon;

  SectionTile(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          // height: 40,
          // width: 40,
          decoration: BoxDecoration(
            color: Colors.blue[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 40,
            color: Colors.white,
          ),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 15, color: Colors.blueGrey),
        )
      ],
    );
  }
}
