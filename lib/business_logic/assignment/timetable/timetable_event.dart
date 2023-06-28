import 'package:equatable/equatable.dart';

import '../../../data/models/time_table_course.dart';

abstract class TimetableEvent extends Equatable {}

class LoadTimetable extends TimetableEvent {
  @override
  List<Object?> get props => [];
}

class UpdateTimetable extends TimetableEvent {
  final List<TimeTableCourse> courses;
  UpdateTimetable(this.courses);
  @override
  List<Object?> get props => [courses];
}

class UpdateTimetableCourse extends TimetableEvent {
  final TimeTableCourse course;
  UpdateTimetableCourse(this.course);
  @override
  List<Object?> get props => [course];
}

class DeleteTimetableCourse extends TimetableEvent {
  final TimeTableCourse course;
  DeleteTimetableCourse(this.course);
  @override
  List<Object?> get props => [course];
}

class AddTimetableCourse extends TimetableEvent {
  final TimeTableCourse course;
  AddTimetableCourse(this.course);
  @override
  List<Object?> get props => [course];
}
