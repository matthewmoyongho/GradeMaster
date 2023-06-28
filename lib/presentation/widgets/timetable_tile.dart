import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/assignment/timetable/timetable_bloc.dart';
import '../../business_logic/assignment/timetable/timetable_event.dart';
import '../../data/models/time_table_course.dart';

class TimeTableTile extends StatelessWidget {
  TimeTableCourse timetableCourse;

  TimeTableTile({required this.timetableCourse});
  void deleteCourse(BuildContext context, TimeTableCourse course) async {
    await showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                backgroundColor: Colors.blue,
                title: const Text('Delete Course'),
                content: Text(
                    'Are you sure delete ${course.courseCode} from Timetable?'),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(primary: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text(
                      'No',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(primary: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ) ??
            false
        ? BlocProvider.of<TimetableBloc>(context)
            .add(DeleteTimetableCourse(course))
        : null;
  }

  @override
  Widget build(BuildContext context) {
    TimeOfDay startTime = TimeOfDay(
      hour: (timetableCourse.startTime).toString().length < 3
          ? int.parse((timetableCourse.startTime.toString()).substring(0, 1))
          : int.parse((timetableCourse.startTime.toString()).substring(0, 2)),
      minute: (timetableCourse.startTime).toString().length < 3
          ? 0
          : int.parse(
              (timetableCourse.startTime.toString()).substring(
                  2, (timetableCourse.startTime).toString().length > 3 ? 4 : 3),
            ),
    );
    TimeOfDay stopTime = TimeOfDay(
      hour: (timetableCourse.stopTime).toString().length < 3
          ? int.parse((timetableCourse.stopTime.toString()).substring(0, 1))
          : int.parse((timetableCourse.stopTime.toString()).substring(0, 2)),
      minute: (timetableCourse.stopTime).toString().length < 3
          ? 0
          : int.parse(
              (timetableCourse.stopTime.toString()).substring(
                  2, (timetableCourse.stopTime).toString().length > 3 ? 4 : 3),
            ),
    );
    return Card(
      child: ListTile(
        title: Text(
          timetableCourse.title!,
          style: const TextStyle(fontSize: 15),
          softWrap: true,
        ),
        leading: FittedBox(
          child: Text(
            timetableCourse.courseCode,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.blueGrey),
          ),
        ),
        subtitle: Text(
          'Time: ${startTime.format(context)} - ${stopTime.format(context)}',
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.blueGrey),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            deleteCourse(context, timetableCourse);
          },
        ),
      ),
    );
  }
}
