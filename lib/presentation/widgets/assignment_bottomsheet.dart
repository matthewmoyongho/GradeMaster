import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../business_logic/assignment/assignment_bloc.dart';
import '../../business_logic/assignment/assignment_event.dart';
import '../../business_logic/assignment/assignment_state.dart';
import '../../data/models/assignment.dart';

class AssignmentBottomSheet extends StatefulWidget {
  String? loadedId;

  AssignmentBottomSheet({this.loadedId});

  @override
  State<AssignmentBottomSheet> createState() => _AssignmentBottomSheetState();
}

class _AssignmentBottomSheetState extends State<AssignmentBottomSheet> {
  final formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();

  DateTime date = DateTime.now();
  late String code;
  String? title;
  late String body;
  String? lecturer;

  final dateFocusNode = FocusNode();
  final titleFocusNode = FocusNode();
  final bodyFocusNode = FocusNode();
  final lecturerFocusNode = FocusNode();

  // void _save() {
  //   final form = formKey.currentState;
  //   if (form!.validate()) {
  //     form.save();
  //     print('saved');
  //     Assignment assignment = Assignment(
  //         courseCode: code,
  //         body: body,
  //         dueDate: Timestamp.fromDate(date),
  //         title: title!,
  //         lecture: lecturer!);
  //     //TODO: Add a try and catch here
  //     BlocProvider.of<AssignmentBloc>(context).add(
  //       AddAssignment(assignment),
  //     );
  //     print('But could not add');
  //   }
  // }

  void showAlertDialog(BuildContext context, String message) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60)),
              backgroundColor: Colors.blue[900],
              title: const Text(
                'An error occurred!',
                style: TextStyle(color: Colors.white),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 70,
                  ),
                  Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Ok',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ))
              ],
            ));
  }

  @override
  void dispose() {
    super.dispose();
    dateController.dispose();
    dateFocusNode.dispose();
    titleFocusNode.dispose();
    bodyFocusNode.dispose();
    lecturerFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return BlocBuilder<AssignmentBloc, AssignmentState>(
      builder: (context, state) {
        // if (widget.loadedId != null) {
        //   context
        //       .read<AssignmentBloc>()
        //       .add(GetAssignment(widget.loadedId ?? ''));
        // }
        if (state is AssignmentsLoaded) {
          if (widget.loadedId != null) {
            final Assignment assignment = state.assignments.firstWhere(
                (assignment) => assignment.docId == widget.loadedId);
            lecturer = assignment.lecture;
            body = assignment.body;
            title = assignment.title!;
            code = assignment.courseCode;
            dateController.text = assignment.dueDate.toString();
          } else {
            lecturer = '';
            title = '';
            body = '';
            code = '';
          }
        } else {
          lecturer = '';
          title = '';
          body = '';
          code = '';
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
              child: Form(
                key: formKey,
                child: ListView(controller: draggableController, children: [
                  const Text(
                    'Add Assignment',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: true,
                    initialValue: code,
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
                      FocusScope.of(context).requestFocus(titleFocusNode);
                    },
                    keyboardType: TextInputType.text,
                    maxLength: 10,
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
                    onFieldSubmitted: (val) {
                      FocusScope.of(context).requestFocus(bodyFocusNode);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    focusNode: bodyFocusNode,
                    initialValue: body,
                    onSaved: (val) => setState(() {
                      body = val!;
                    }),
                    enableSuggestions: true,
                    textCapitalization: TextCapitalization.sentences,
                    key: const ValueKey('body'),
                    validator: (val) =>
                        val == null ? 'This field is required' : null,
                    decoration: const InputDecoration(
                      label: Text(
                        'Body - (required)',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    maxLines: 4,
                    onFieldSubmitted: (val) {
                      FocusScope.of(context).requestFocus(lecturerFocusNode);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    focusNode: lecturerFocusNode,
                    initialValue: lecturer,
                    onFieldSubmitted: (val) {
                      FocusScope.of(context).requestFocus(dateFocusNode);
                    },
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    onSaved: (val) => setState(() {
                      lecturer = val!;
                    }),
                    key: const ValueKey('lecturer'),
                    decoration: const InputDecoration(
                      label: Text(
                        'Lecturer - (optional)',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    focusNode: dateFocusNode,
                    controller: dateController,
                    key: const ValueKey('date'),
                    //initialValue: DateFormat('MMM dd, yyyy').format(_date),
                    decoration: const InputDecoration(
                      label: Text(
                        'Due date',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    readOnly: true,
                    onTap: _showDatePicker,
                    textInputAction: TextInputAction.next,
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
                            primary: Colors.blue[900]),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            Assignment assignment = Assignment(
                                courseCode: code,
                                body: body,
                                dueDate: Timestamp.fromDate(date),
                                title: title!,
                                lecture: lecturer!);

                            try {
                              context.read<AssignmentBloc>().add(
                                    AddAssignment(assignment),
                                  );
                              Navigator.pop(context);
                            } catch (e) {
                              showAlertDialog(context,
                                  'Could not add assignment. Please try again');
                            }
                          }
                        },
                        child: const Text(
                          'Add',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(deviceSize.width * 0.3, 40),
                              primary: Colors.blue[900]),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(fontSize: 20),
                          )),
                    ],
                  )
                ]),
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

  void _showDatePicker() async {
    final chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (chosenDate != null && chosenDate != date) {
      setState(() {
        date = chosenDate;
        dateController.text = DateFormat.yMMMd().format(date);
      });
    }
  }
}
