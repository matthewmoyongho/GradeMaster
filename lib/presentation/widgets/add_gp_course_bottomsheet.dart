import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/gp_course/gp_course_bloc.dart';
import '../../business_logic/gp_course/gp_course_event.dart';
import '../../business_logic/gp_course/gp_course_state.dart';
import '../../data/models/gp_course.dart';

class AddGPCourseBottomSheet extends StatefulWidget {
  String? loadedId;
  String year;
  String semester;
  AddGPCourseBottomSheet(
      {required this.year, this.loadedId, required this.semester});

  @override
  State<AddGPCourseBottomSheet> createState() => _AddGPCourseBottomSheet();
}

class _AddGPCourseBottomSheet extends State<AddGPCourseBottomSheet> {
  final formKey = GlobalKey<FormState>();
  String? code;
  String? title;
  String? selectedGrade;
  late int unit;
  late int points;
  //late String semester;
  final gradeFocusNode = FocusNode();
  final titleFocusNode = FocusNode();
  final unitFocusNode = FocusNode();

  List grades = ['A', 'B', 'C', 'D', 'E', 'F'];
  List semesters = ['First Semester', 'Second Semester'];

  @override
  void dispose() {
    super.dispose();

    gradeFocusNode.dispose();
    titleFocusNode.dispose();
    unitFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return BlocBuilder<GPCourseBloc, GPCourseState>(
      builder: (context, state) {
        if (state is GPCourseLoaded) {
          if (widget.loadedId != null) {
            final course = state.courses
                .firstWhere((course) => course.id == widget.loadedId);
            code = course.code;
            title = course.title;
            selectedGrade = course.grade;
            unit = course.creditUnit;
            points = course.points;
          }
        } else {
          code = '';
          title = '';
          selectedGrade = '';
          unit = 0;
        }
        return makeDismissible(
          DraggableScrollableSheet(
            initialChildSize: 0.755,
            minChildSize: 0.4,
            maxChildSize: 0.9,
            builder: (_, draggableController) => Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              child: BlocBuilder<GPCourseBloc, GPCourseState>(
                builder: (context, state) {
                  if (state is GPCourseLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return Form(
                    key: formKey,
                    child: ListView(controller: draggableController, children: [
                      const Text(
                        'Add Course',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        // autofocus: true,
                        initialValue: code ?? '',
                        textInputAction: TextInputAction.next,
                        onSaved: (val) => setState(() {
                          code = val!;
                        }),
                        validator: (val) =>
                            val == null ? 'This field is required' : null,
                        key: const ValueKey('code'),
                        decoration: const InputDecoration(
                          label: Text(
                            'Course code - (required)',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        onFieldSubmitted: (val) {
                          FocusScope.of(context).requestFocus(unitFocusNode);
                        },
                        keyboardType: TextInputType.text,
                        maxLength: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        focusNode: unitFocusNode,
                        initialValue:
                            widget.loadedId != null ? unit.toString() : null,
                        onSaved: (val) => setState(() {
                          unit = int.parse(val!);
                        }),
                        key: const ValueKey('unit'),
                        validator: (val) =>
                            val == null ? 'This field is required' : null,
                        decoration: const InputDecoration(
                          label: Text(
                            'Credit Unit - (required)',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (val) {
                          FocusScope.of(context).requestFocus(gradeFocusNode);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField(
                        focusNode: gradeFocusNode,
                        key: const ValueKey('grade'),
                        decoration: const InputDecoration(
                          label: Text(
                            'Grade - (required)',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        //value: endTime,
                        items: grades
                            .map((grade) => DropdownMenuItem(
                                  value: grade,
                                  child: Text(grade.toString()),
                                ))
                            .toList(),
                        value: selectedGrade,
                        onChanged: (val) {
                          setState(() {
                            selectedGrade = val!.toString();
                          });
                        },
                        onSaved: (val) {
                          setState(() {
                            selectedGrade = val!.toString();
                          });

                          if (selectedGrade == 'A') {
                            points = unit * 5;
                          } else if (selectedGrade == 'B') {
                            points = unit * 4;
                          } else if (selectedGrade == 'C') {
                            points = unit * 3;
                          } else if (selectedGrade == 'D') {
                            points = unit * 2;
                          } else if (selectedGrade == 'E') {
                            points = unit * 1;
                          } else if (selectedGrade == 'F') {
                            points = unit * 0;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        focusNode: titleFocusNode,
                        initialValue: title,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.next,
                        onSaved: (val) => setState(() {
                          title = val!;
                        }),
                        key: const ValueKey('courseTitle'),
                        decoration: const InputDecoration(
                          label: Text(
                            'Course Title - (optional)',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(deviceSize.width * 0.3, 40),
                                backgroundColor: Colors.blue[900]),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                              }

                              GPCourse course = GPCourse(
                                grade: selectedGrade!,
                                points: points,
                                code: code!,
                                creditUnit: unit,
                                year: widget.year,
                                semester: widget.semester,
                                title: title,
                              );
                              try {
                                if (widget.loadedId != null) {
                                  context.read<GPCourseBloc>().add(
                                      UpdateGPCourse(
                                          course: course,
                                          id: widget.loadedId!));
                                } else {
                                  context
                                      .read<GPCourseBloc>()
                                      .add(AddGPCourse(course: course));
                                }
                              } catch (e) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('An error occurred'),
                                    content: Text(
                                      'Could not add ${code ?? ''} to your record. Maybe you should check tour network and try again',
                                    ),
                                  ),
                                );
                              }
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Add',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(deviceSize.width * 0.3, 40),
                                backgroundColor: Colors.blue[900]),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      )
                    ]),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget makeDismissible(Widget child) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: GestureDetector(
        onTap: () {},
        child: child,
      ),
    );
  }
}
