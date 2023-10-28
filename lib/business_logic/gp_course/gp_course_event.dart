import 'package:equatable/equatable.dart';

import '../../data/models/gp_course.dart';

class GPCoursesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadGPCourses extends GPCoursesEvent {
  LoadGPCourses();
  @override
  List<Object?> get props => [];
}

class UpdateGPCourse extends GPCoursesEvent {
  final GPCourse course;
  final String id;
  UpdateGPCourse({required this.course, required this.id});

  @override
  List<Object?> get props => [course];
}

class AddGPCourse extends GPCoursesEvent {
  final GPCourse course;
  AddGPCourse({required this.course});

  @override
  List<Object?> get props => [course];
}

class DeleteGPCourse extends GPCoursesEvent {
  final GPCourse course;
  DeleteGPCourse({required this.course});

  @override
  List<Object?> get props => [course];
}

class ClearGPRecord extends GPCoursesEvent {
  ClearGPRecord();
  @override
  List<Object?> get props => [];
}

class ClearYearRecord extends GPCoursesEvent {
  final String year;
  ClearYearRecord(this.year);
  @override
  List<Object?> get props => [year];
}

class ClearSemesterRecord extends GPCoursesEvent {
  final String year;
  final String semester;
  ClearSemesterRecord({required this.year, required this.semester});
  @override
  List<Object?> get props => [year, semester];
}

class GetYearGP extends GPCoursesEvent {
  final String year;

  GetYearGP({required this.year});
  @override
  List<Object?> get props => [
        year,
      ];
}
