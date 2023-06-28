import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../data/models/time_table_course.dart';
import '../../../data/repositories/timetable/timetable_repository.dart';
import 'timetable_event.dart';
import 'timetable_state.dart';

class TimetableBloc extends Bloc<TimetableEvent, TimetableState> {
  final TimeTableRepository _timetableRepository;
  late final StreamSubscription? _timeTableSubscription;

  TimetableBloc({required TimeTableRepository timetableRepository})
      : _timetableRepository = timetableRepository,
        super(TimetableLoading()) {
    on<LoadTimetable>(_loadAllCourses);
    on<AddTimetableCourse>(_addToTimeTable);
    on<DeleteTimetableCourse>(_removeFromTimeTable);
  }

  void _loadAllCourses(
      LoadTimetable event, Emitter<TimetableState> emit) async {
    emit(TimetableLoading());

    List<TimeTableCourse> courses = [];
    courses.addAll(await _timetableRepository.getAllTimeTableCourses());
    emit(
      TimetableLoaded(courses: courses),
    );
  }

  void _addToTimeTable(
      AddTimetableCourse event, Emitter<TimetableState> emit) async {
    try {
      _timetableRepository.addTimetable(event.course);
    } catch (e) {
      rethrow;
    }

    List<TimeTableCourse> courses =
        await _timetableRepository.getAllTimeTableCourses();
    emit(TimetableLoaded(courses: courses));
  }

  void _removeFromTimeTable(
      DeleteTimetableCourse event, Emitter<TimetableState> emit) async {
    _timetableRepository.deleteTimetable(event.course.docId!);
    List<TimeTableCourse> courses = List.from(state.courses);
    courses.remove(event.course);
    emit(TimetableLoaded(courses: courses));
  }
}
