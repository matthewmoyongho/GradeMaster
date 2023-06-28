import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/assignment/assignment_bloc.dart';
import '../../business_logic/assignment/assignment_event.dart';
import '../../business_logic/assignment/assignment_state.dart';
import '../../data/models/assignment.dart';
import '../widgets/assignment_bottomsheet.dart';

class AssignmentDetailsScreen extends StatelessWidget {
  const AssignmentDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String assignmentId =
        ModalRoute.of(context)!.settings.arguments as String;
    return BlocBuilder<AssignmentBloc, AssignmentState>(
      builder: (context, state) {
        final Assignment? loadedAssignment;

        if (state is AssignmentsLoaded) {
          loadedAssignment = state.assignments
              .firstWhere((assignment) => assignment.docId == assignmentId);
        } else {
          loadedAssignment = null;
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[900],
            title: Text(
                '${loadedAssignment!.courseCode.toUpperCase()} Assignment'),
            actions: [
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        //barrierColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30))),
                        isScrollControlled: true,
                        context: context,
                        builder: (_) => AssignmentBottomSheet(
                              loadedId: assignmentId,
                            ));
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(
                onPressed: () async {
                  await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => AlertDialog(
                      backgroundColor: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      title: const Text('Confirm to delete'),
                      content: const Text(
                          'Are you sure you want to delete this assignment'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).pop(true);
                            context
                                .read<AssignmentBloc>()
                                .add(DeleteAssignment(loadedAssignment!));
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'DELETE',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).pop(false);
                          },
                          child: const Text(
                            'CANCEL',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.delete),
                color: Colors.orangeAccent,
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              loadedAssignment.body,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        );
      },
    );
  }
}
