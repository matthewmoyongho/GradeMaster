import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../business_logic/assignment/assignment_bloc.dart';
import '../../business_logic/assignment/assignment_event.dart';
import '../../business_logic/assignment/assignment_state.dart';
import '../../constants.dart';
import '../../data/models/assignment.dart';

class AssignmentTile extends StatefulWidget {
  final Assignment assignment;
  AssignmentTile({
    required this.assignment,
  });

  @override
  State<AssignmentTile> createState() => _AssignmentTileState();
}

class _AssignmentTileState extends State<AssignmentTile> {
  String time = DateFormat.yMMMd().format(DateTime.now());
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: expanded ? 200 : 95,
      duration: const Duration(milliseconds: 300),
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            BlocBuilder<AssignmentBloc, AssignmentState>(
              builder: (context, state) {
                Assignment? assignment;
                if (state is AssignmentsLoaded) {
                  assignment = state.assignments.firstWhere((assignment) =>
                      assignment.docId == widget.assignment.docId);
                }
                return ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(kAssignmentDetailsScreen,
                        arguments: assignment!.docId);
                  },
                  leading: IconButton(
                    icon:
                        Icon(expanded ? Icons.expand_less : Icons.expand_more),
                    onPressed: () {
                      setState(() {
                        expanded = !expanded;
                      });
                    },
                  ),
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  trailing: Checkbox(
                    value: assignment!.isDone,
                    onChanged: (val) {
                      setState(() {
                        context.read<AssignmentBloc>().add(
                              UpdateAssignment(
                                assignment!
                                    .copyWith(isDone: !assignment.isDone!),
                              ),
                            );
                      });
                    },
                    activeColor: Colors.blue[900],
                  ),
                  title: assignment.title!.isEmpty
                      ? Text(
                          '${assignment.courseCode.toUpperCase()} ',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueGrey,
                              decoration: assignment.isDone!
                                  ? TextDecoration.lineThrough
                                  : null),
                        )
                      : Text(
                          '${assignment.courseCode.toUpperCase()} - ${assignment.title!.substring(0, assignment.title!.length > 20 ? 20 : assignment.title!.length)} ...',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              decoration: assignment.isDone!
                                  ? TextDecoration.lineThrough
                                  : null),
                        ),
                  subtitle: Text(
                    'Due by - ${DateFormat.yMMMd().format((widget.assignment.dueDate).toDate())}',
                    style:
                        const TextStyle(fontSize: 16, color: Colors.blueGrey),
                  ),
                );
              },
            ),
            AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                height: expanded ? min(70, 100) : 0,
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(widget.assignment.body),
                ))
          ],
        ),
      ),
    );
  }
}
