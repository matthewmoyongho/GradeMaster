import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../data/models/assignment.dart';
import '../../data/repositories/assignment/assignment_repository.dart';
import 'assignment_event.dart';
import 'assignment_state.dart';

class AssignmentBloc extends Bloc<AssignmentEvent, AssignmentState> {
  final AssignmentRepository _assignmentRepository;
  late final StreamSubscription? _assignmentSubscription;

  AssignmentBloc({required AssignmentRepository assignmentRepository})
      : _assignmentRepository = assignmentRepository,
        super(AssignmentsLoading()) {
    on<LoadAssignments>(_loadAllAssignments);
    on<AddAssignment>(_addToAssignments);
    on<UpdateAssignment>(_updateFavourite);
  }

  void _loadAllAssignments(
      LoadAssignments event, Emitter<AssignmentState> emit) async {
    emit(AssignmentsLoading());
    List<Assignment> assignments = [];
    assignments.addAll(await _assignmentRepository.getAllAssignment());
    print('Loading length is ${assignments.length}');
    emit(AssignmentsLoaded(assignments: assignments));
    print('New state is loaded');
  }

  // void _loadAssignments(
  //     LoadAssignments event, Emitter<AssignmentState> emit) async {
  //   List<Assignment> assignments = [];
  //   emit(AssignmentsLoaded(assignments: assignments));
  //   emit(AssignmentsLoading());
  //
  //   assignments.addAll(await _assignmentRepository.getAllAssignment());
  //   emit(AssignmentsLoaded(assignments: assignments));
  // }

  void _updateFavourite(
      UpdateAssignment event, Emitter<AssignmentState> emit) async {
    emit(AssignmentsLoading());
    await _assignmentRepository.upDateAssignment(event.assignment);
    List<Assignment> assignments =
        await _assignmentRepository.getAllAssignment();
    emit(AssignmentsLoaded(assignments: assignments));
  }

  void _addToAssignments(
      AddAssignment event, Emitter<AssignmentState> emit) async {
    await _assignmentRepository.addAssignment(event.assignment);
    List<Assignment> assignments =
        await _assignmentRepository.getAllAssignment();
    emit(AssignmentsLoaded(assignments: assignments));
  }
}
