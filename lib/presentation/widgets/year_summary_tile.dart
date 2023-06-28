import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/gp_course/gp_course_bloc.dart';
import '../../business_logic/gp_course/gp_course_state.dart';
import '../../data/models/gp_course.dart';
import 'gp_progress_bar.dart';

class YearSummaryTile extends StatefulWidget {
  final String year;

  YearSummaryTile({required this.year});

  @override
  _YearSummaryTileState createState() => _YearSummaryTileState();
}

class _YearSummaryTileState extends State<YearSummaryTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: BlocBuilder<GPCourseBloc, GPCourseState>(
                builder: (context, state) {
                  List<GPCourse> yearCourses = [];
                  if (state is GPCourseLoaded) {
                    yearCourses.addAll(
                      state.courses
                          .where((course) => course.year == widget.year),
                    );
                    String yearGP;
                    String firstSemesterGP;
                    double firstSemesterPoints = 0;
                    double firstSemesterUnits = 0;
                    double secondSemesterPoints = 0;
                    double secondSemesterUnits = 0;
                    String secondSemesterGP;
                    double totalPoints = 0.0;
                    double totalUnits = 0.0;
                    for (var course in yearCourses) {
                      totalUnits = totalUnits + course.creditUnit;
                      totalPoints = totalPoints + course.points;
                      if (course.semester == 'First Semester') {
                        firstSemesterPoints =
                            firstSemesterPoints + course.points;
                        firstSemesterUnits =
                            firstSemesterUnits + course.creditUnit;
                      } else {
                        secondSemesterPoints =
                            secondSemesterPoints + course.points;
                        secondSemesterUnits =
                            secondSemesterUnits + course.creditUnit;
                      }
                    }
                    yearGP = (totalPoints / totalUnits).toStringAsFixed(2);
                    firstSemesterGP = (firstSemesterPoints / firstSemesterUnits)
                        .toStringAsFixed(2);
                    secondSemesterGP =
                        (secondSemesterPoints / secondSemesterUnits)
                            .toStringAsFixed(2);
                    return double.parse(yearGP).isNaN
                        ? const SizedBox()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.year,
                                    style: TextStyle(
                                        color: Colors.blue[900], fontSize: 18),
                                  ),
                                  Text(
                                    yearGP,
                                    style: TextStyle(
                                        color: Colors.blue[900], fontSize: 18),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              double.parse(firstSemesterGP).isNaN
                                  ? const SizedBox()
                                  : Text('First Semester $firstSemesterGP'),
                              const SizedBox(
                                height: 5,
                              ),
                              GPProgressBar(double.parse(firstSemesterGP)),
                              const SizedBox(
                                height: 5,
                              ),
                              double.parse(secondSemesterGP).isNaN
                                  ? const SizedBox()
                                  : Text('Second Semester $secondSemesterGP'),
                              const SizedBox(
                                height: 5,
                              ),
                              GPProgressBar(double.parse(secondSemesterGP)),
                            ],
                          );
                  } else {
                    return Text(
                      '',
                      style: TextStyle(color: Colors.blue[900], fontSize: 18),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
