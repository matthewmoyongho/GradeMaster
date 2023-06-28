import 'package:equatable/equatable.dart';

import '../../data/models/gp_course.dart';

class GPCourseState extends Equatable {
  final List<GPCourse> courses;
  const GPCourseState({required this.courses});
  List<Object?> get props => [];
}

class GPCourseLoading extends GPCourseState {
  GPCourseLoading() : super(courses: []);
}

class GPCourseLoaded extends GPCourseState {
  final List<GPCourse> courses;
  String cgpa;
  final bool yearAdded;
  final bool yearDeleted;
  final bool recordsCleared;
  final bool semesterCleared;
  final String degree;
  final String diploma;
  GPCourseLoaded(
      {required this.cgpa,
      required this.diploma,
      required this.degree,
      required this.courses,
      this.recordsCleared = false,
      this.yearAdded = false,
      this.yearDeleted = false,
      this.semesterCleared = false})
      : super(courses: courses);

  @override
  List<Object?> get props =>
      [courses, yearDeleted, yearAdded, recordsCleared, semesterCleared];
}

class SemesterGPLoading extends GPCourseState {
  SemesterGPLoading() : super(courses: []);
}

class SemesterGPLoaded extends GPCourseState {
  final List<GPCourse> courses;
  final String semesterGP;
  final int numberOfA;
  final int numberOfB;
  final int numberOfC;
  final int numberOfD;
  final int numberOfE;
  final int numberOfF;
  final List<GPCourse> semesterCourses;
  final int totalUnits;
  SemesterGPLoaded(
      {required this.courses,
      required this.totalUnits,
      required this.semesterCourses,
      required this.semesterGP,
      required this.numberOfA,
      required this.numberOfB,
      required this.numberOfC,
      required this.numberOfD,
      required this.numberOfE,
      required this.numberOfF})
      : super(courses: courses);
  @override
  List<Object?> get props => [courses, semesterGP];
}

class YearGPALoading extends GPCourseState {
  final List<GPCourse> courses;
  YearGPALoading(this.courses) : super(courses: courses);
}

class YearGPLoaded extends GPCourseState {
  final List<GPCourse> courses;
  final String yearGP;
  YearGPLoaded(this.courses, this.yearGP) : super(courses: courses);
  @override
  List<Object?> get props => [courses, yearGP];
}

class CGPALoaded extends GPCourseState {
  final List<GPCourse> courses;
  final String cgpa;
  CGPALoaded(this.courses, this.cgpa) : super(courses: courses);
  @override
  List<Object?> get props => [courses, cgpa];
}

class CourseLoaded extends GPCourseState {
  final GPCourse course;
  CourseLoaded(this.course) : super(courses: []);

  @override
  List<Object?> get props => [course];
}
