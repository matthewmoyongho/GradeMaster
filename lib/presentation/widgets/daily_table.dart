import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_acad/presentation/widgets/timetable_tile.dart';

import '../../business_logic/assignment/timetable/timetable_bloc.dart';
import '../../business_logic/assignment/timetable/timetable_state.dart';
import '../../data/models/time_table_course.dart';

class DailyTable extends StatelessWidget {
  String day;

  DailyTable({required this.day});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          day.toUpperCase(),
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.blueGrey),
        ),
        BlocBuilder<TimetableBloc, TimetableState>(
          builder: (context, state) {
            List<TimeTableCourse> courses = [];
            if (state is TimetableLoaded) {
              courses
                  .addAll(state.courses.where((course) => course.day == day));
            }

            return courses.isEmpty
                ? Container(
                    height: 100,
                    width: double.infinity,
                    child: const Center(
                      child: Text('No Lecture for today🤗😇'),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      return TimeTableTile(
                        timetableCourse: courses[index],
                      );
                    });
          },
        ),
      ],
    );
  }
}
