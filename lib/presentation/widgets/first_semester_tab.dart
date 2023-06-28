import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/gp_course/gp_course_bloc.dart';
import '../../business_logic/gp_course/gp_course_state.dart';
import '../../data/models/gp_course.dart';
import '../../data/models/grades.dart';
import 'grade_summary_gridview.dart';
import 'grade_summary_table.dart';

class FirstSemesterTab extends StatelessWidget {
  final String year;

  FirstSemesterTab(this.year);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:
          BlocBuilder<GPCourseBloc, GPCourseState>(builder: (context, state) {
        List<GPCourse> semesterCourses = [];
        if (state is GPCourseLoaded) {
          semesterCourses.addAll(
            state.courses.where((course) =>
                course.semester == 'First Semester' && course.year == year),
          );
          String semesterGP;
          double totalPoints = 0.0;
          double totalUnits = 0.0;
          semesterCourses.forEach((course) {
            totalUnits = totalUnits + course.creditUnit;
            totalPoints = totalPoints + course.points;
          });
          semesterGP = (totalPoints / totalUnits).toStringAsFixed(2);
          int numberOfA =
              semesterCourses.where((course) => course.grade == 'A').length;
          int numberOfB =
              semesterCourses.where((course) => course.grade == 'B').length;
          int numberOfC =
              semesterCourses.where((course) => course.grade == 'C').length;
          int numberOfD =
              semesterCourses.where((course) => course.grade == 'D').length;
          int numberOfE =
              semesterCourses.where((course) => course.grade == 'E').length;
          int numberOfF =
              semesterCourses.where((course) => course.grade == 'F').length;
          return Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue[900],
                  ),
                  child: const Center(
                    child: Text(
                      'SEMESTER GP',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * .5,
                  padding: EdgeInsets.all(15),
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.blue[900],
                  ),
                  child: Center(
                    child: Text(
                      double.parse(semesterGP).isNaN ? '0.00' : semesterGP,
                      style: TextStyle(color: Colors.white, fontSize: 50),
                    ),
                  ),
                ),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.all(15),
                  //height: 50,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.blue[300],
                            child: Text(
                              'Total courses: ${semesterCourses.length}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.blue[300],
                            child: Text(
                              'Total units: ${totalUnits}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                      GradeSummaryGridView(
                        grades: Grades(
                          numberOfA,
                          numberOfB,
                          numberOfC,
                          numberOfD,
                          numberOfE,
                          numberOfF,
                        ),
                      ),
                      GradesSummaryTable(
                          semesterCourses, year, 'First Semester'),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else if (state is GPCourseLoading) {
          return const Center(
            child: Text(
              'Loading...',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 18,
                  color: Colors.blueGrey),
            ),
          );
        }
        return const Center(
          child: Text(
            'Could not load your courses at the moment. Try refreshing your internet connection',
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 18,
                color: Colors.blueGrey),
          ),
        );
      }),
    );
  }
}
