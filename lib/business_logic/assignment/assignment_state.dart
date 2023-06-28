import 'package:equatable/equatable.dart';

import '../../data/models/assignment.dart';

class AssignmentState extends Equatable {
  final List<Assignment> assignments;
  const AssignmentState({required this.assignments});
  List<Object?> get props => [assignments];
}

class AssignmentsLoading extends AssignmentState {
  AssignmentsLoading() : super(assignments: []);
}

class AssignmentsLoaded extends AssignmentState {
  final List<Assignment> assignments;
  AssignmentsLoaded({required this.assignments})
      : super(assignments: assignments);

  @override
  List<Object?> get props => [assignments];
}

class AssignmentLoaded extends AssignmentState {
  final Assignment? assignment;
  AssignmentLoaded(this.assignment) : super(assignments: []);
}
