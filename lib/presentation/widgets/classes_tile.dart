import 'package:flutter/material.dart';

import '../../data/models/time_table_course.dart';

class ClassesTile extends StatelessWidget {
  int index;
  ClassesTile({
    Key? key,
    required this.index,
    required this.document,
  }) : super(key: key);

  final List<TimeTableCourse> document;

  @override
  Widget build(BuildContext context) {
    TimeOfDay startTime = TimeOfDay(
        hour: int.parse((document[index].startTime.toString()).substring(0, 2)),
        minute: int.parse((document[index].startTime.toString()).substring(
            2, (document[index].startTime).toString().length > 3 ? 4 : 3)));
    TimeOfDay stopTime = TimeOfDay(
        hour: int.parse((document[index].stopTime.toString()).substring(0, 2)),
        minute: int.parse((document[index].stopTime.toString()).substring(
            2, (document[index].stopTime).toString().length > 3 ? 4 : 3)));
    return Card(
      child: ListTile(
        title: RichText(
          text: TextSpan(
              style: const TextStyle(fontSize: 18, color: Colors.black),
              children: [
                TextSpan(text: document[index].courseCode),
                TextSpan(
                    text:
                        ' - ${(document[index].title).toString().substring(0, document[index].title.toString().length > 20 ? 20 : document[index].title.toString().length)}'),
                TextSpan(
                    text: (document[index].title).toString().length > 20
                        ? '...'
                        : ''),
              ]),
        ),
        subtitle: Text(
          'Time: ${startTime.format(context)} - ${stopTime.format(context)}',
          style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
        ),
      ),
    );
  }
}
