import 'package:flutter/material.dart';

import '../../constants.dart';

class CourseLectureTile extends StatelessWidget {
  String date;
  String courseTitle;
  String lecturer;
  String month;
  String time;
  CourseLectureTile(
      {required this.month,
      required this.courseTitle,
      required this.date,
      required this.lecturer,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      width: MediaQuery.of(context).size.width * 0.53,
      height: MediaQuery.of(context).size.height * 0.2,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blueAccent[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Column(
            children: [
              const Text(
                'Today',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                '$kDate $kMonth',
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  courseTitle.length > 20
                      ? '${courseTitle.substring(0, 20)}...'
                      : courseTitle,
                  //overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  time,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
