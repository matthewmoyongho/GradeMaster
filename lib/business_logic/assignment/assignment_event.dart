import 'package:equatable/equatable.dart';

import '../../data/models/assignment.dart';

abstract class AssignmentEvent extends Equatable {}

class LoadAssignments extends AssignmentEvent {
  LoadAssignments();
  @override
  List<Object?> get props => [];
}

class UpdateAssignments extends AssignmentEvent {
  final List<Assignment> assignments;
  UpdateAssignments({required this.assignments});

  @override
  List<Object?> get props => [assignments];
}

class GetAssignment extends AssignmentEvent {
  final String id;
  GetAssignment(this.id);
  @override
  List<Object?> get props => [id];
}

class AddAssignment extends AssignmentEvent {
  final Assignment assignment;
  AddAssignment(this.assignment);
  @override
  List<Object?> get props => [assignment];
}

class DeleteAssignment extends AssignmentEvent {
  final Assignment assignment;
  DeleteAssignment(this.assignment);
  @override
  List<Object?> get props => [assignment];
}

class UpdateAssignment extends AssignmentEvent {
  final Assignment assignment;
  UpdateAssignment(this.assignment);
  @override
  List<Object?> get props => [assignment];
}

class ToggleDone extends AssignmentEvent {
  final bool done;
  final Assignment assignment;
  ToggleDone({required this.done, required this.assignment});
  @override
  List<Object?> get props => [done, assignment];
}
