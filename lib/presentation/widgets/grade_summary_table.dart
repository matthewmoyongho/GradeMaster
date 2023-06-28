import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/gp_course/gp_course_bloc.dart';
import '../../business_logic/gp_course/gp_course_event.dart';
import '../../business_logic/gp_course/gp_course_state.dart';
import '../../data/models/gp_course.dart';
import 'add_gp_course_bottomsheet.dart';

class GradesSummaryTable extends StatelessWidget {
  List<GPCourse> gpCourses;
  String semester;
  String year;
  GradesSummaryTable(this.gpCourses, this.year, this.semester, {super.key});

  showAlertDialog(
    BuildContext context,
    GPCourse course,
  ) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60)),
              title: const Text(
                'Action alert!',
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                    size: 70,
                  ),
                  Text(
                    'Choose an action to be performed on the selected course',
                  ),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          showModalBottomSheet(
                            //barrierColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30))),
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => AddGPCourseBottomSheet(
                              year: year,
                              semester: semester,
                              loadedId: course.id,
                            ),
                          );
                        },
                        child: const Text(
                          'Edit',
                          style: TextStyle(fontSize: 20),
                        )),
                    BlocBuilder<GPCourseBloc, GPCourseState>(
                      builder: (context, state) {
                        return TextButton(
                          onPressed: () async {
                            context
                                .read<GPCourseBloc>()
                                .add(DeleteGPCourse(course: course));
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Delete',
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                      },
                    ),
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(fontSize: 20),
                        )),
                  ],
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        Container(
          height: 50,
          width: double.infinity,
          color: Colors.blue[300],
          child: Row(
            children: [
              Expanded(
                child: Container(
                  //color: Colors.blue[300],
                  alignment: Alignment.center,
                  //color: Colors.blue[300],
                  child: const Text('COURSE'),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: const Text('UNIT'),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: const Text('GRADE'),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: List.generate(
              gpCourses.length,
              (index) => GestureDetector(
                    onLongPress: () =>
                        showAlertDialog(context, gpCourses[index]),
                    child: Container(
                      color: index.isEven ? Colors.blue[100] : Colors.white,
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(gpCourses[index].code.toUpperCase()),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(gpCourses[index]
                                  .creditUnit
                                  .toString()
                                  .toUpperCase()),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(gpCourses[index].grade.toUpperCase()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
        )
      ],
    ));
  }
}
