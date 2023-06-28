import 'package:equatable/equatable.dart';

import '../../../data/models/time_table_course.dart';

class TimetableState extends Equatable {
  final List<TimeTableCourse> courses;
  TimetableState({required this.courses});
  @override
  List<Object?> get props => [courses];
}

class TimetableLoading extends TimetableState {
  TimetableLoading() : super(courses: []);
}

class TimetableLoaded extends TimetableState {
  List<TimeTableCourse> courses;
  TimetableLoaded({required this.courses}) : super(courses: courses);

  @override
  List<Object?> get props => [courses];
}
