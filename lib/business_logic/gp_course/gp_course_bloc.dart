import 'package:bloc/bloc.dart';

import '../../data/models/gp_course.dart';
import '../../data/repositories/gp_course/gp_course_repository.dart';
import 'gp_course_event.dart';
import 'gp_course_state.dart';

class GPCourseBloc extends Bloc<GPCoursesEvent, GPCourseState> {
  final GPCourseRepository _courseRepository;

  GPCourseBloc({required GPCourseRepository gpCourseRepository})
      : _courseRepository = gpCourseRepository,
        super(GPCourseLoading()) {
    on<LoadGPCourses>(_loadAllCourses);
    on<AddGPCourse>(_addGPCourse);
    on<DeleteGPCourse>(_deleteCourse);
    on<UpdateGPCourse>(_updateCourse);
    on<ClearGPRecord>(_clearAllRecord);
    on<ClearYearRecord>(_clearYearRecord);
    on<ClearSemesterRecord>(_clearSemester);
  }

  void _loadAllCourses(LoadGPCourses event, Emitter<GPCourseState> emit) async {
    emit(GPCourseLoading());
    List<GPCourse> courses = await _courseRepository.getAllGPCourses();
    String cgpa;
    String degree;
    String diploma;
    double totalPoints = 0.0;
    double totalUnits = 0.0;
    for (var course in courses) {
      totalUnits = totalUnits + course.creditUnit;
      totalPoints = totalPoints + course.points;
    }
    cgpa = (totalPoints / totalUnits).toStringAsFixed(2);
    final gpToDouble = double.parse(cgpa);
    if (gpToDouble > 4.5) {
      degree = 'First Class';
      diploma = 'Distinction';
    } else if (gpToDouble >= 3.5 && gpToDouble < 4.5) {
      degree = 'Second Class Upper';
      diploma = 'Credit';
    } else if (gpToDouble >= 2.4 && gpToDouble < 3.5) {
      degree = 'Second Class Lower';
      diploma = 'Merit';
    } else if (gpToDouble >= 1.5 && gpToDouble < 2.4) {
      degree = 'Third Class';
      diploma = 'Pass';
    } else if (gpToDouble >= 1.0 && gpToDouble < 1.5) {
      degree = 'Pass';
      diploma = 'Pass';
    } else if (gpToDouble >= 0 && gpToDouble < 1.0) {
      degree = 'Fail';
      diploma = 'Fail';
    } else {
      degree = '';
      diploma = '';
    }
    emit(
      GPCourseLoaded(
        courses: courses,
        cgpa: cgpa,
        degree: degree,
        diploma: diploma,
      ),
    );
  }

  void _addGPCourse(AddGPCourse event, Emitter<GPCourseState> emit) async {
    emit(GPCourseLoading());
    _courseRepository.addCourse(event.course);
    List<GPCourse> courses = await _courseRepository.getAllGPCourses();
    String cgpa;
    String degree;
    String diploma;
    double totalPoints = 0.0;
    double totalUnits = 0.0;
    for (var course in courses) {
      totalUnits = totalUnits + course.creditUnit;
      totalPoints = totalPoints + course.points;
    }
    cgpa = (totalPoints / totalUnits).toStringAsFixed(2);
    final gpToDouble = double.parse(cgpa);
    if (gpToDouble > 4.5) {
      degree = 'First Class';
      diploma = 'Distinction';
    } else if (gpToDouble >= 3.5 && gpToDouble < 4.5) {
      degree = 'Second Class Upper';
      diploma = 'Credit';
    } else if (gpToDouble >= 2.4 && gpToDouble < 3.5) {
      degree = 'Second Class Lower';
      diploma = 'Merit';
    } else if (gpToDouble >= 1.5 && gpToDouble < 2.4) {
      degree = 'Third Class';
      diploma = 'Pass';
    } else if (gpToDouble >= 1.0 && gpToDouble < 1.5) {
      degree = 'Pass';
      diploma = 'Pass';
    } else {
      degree = 'Fail';
      diploma = 'Fail';
    }
    emit(
      GPCourseLoaded(
        courses: courses,
        cgpa: cgpa,
        degree: degree,
        diploma: diploma,
      ),
    );
  }

  void _deleteCourse(DeleteGPCourse event, Emitter<GPCourseState> emit) async {
    emit(GPCourseLoading());
    _courseRepository.deleteCourse(event.course.id!);
    List<GPCourse> courses = await _courseRepository.getAllGPCourses();
    String cgpa;
    String degree;
    String diploma;
    double totalPoints = 0.0;
    double totalUnits = 0.0;
    for (var course in courses) {
      totalUnits = totalUnits + course.creditUnit;
      totalPoints = totalPoints + course.points;
    }
    cgpa = (totalPoints / totalUnits).toStringAsFixed(2);
    final gpToDouble = double.parse(cgpa);
    if (gpToDouble > 4.5) {
      degree = 'First Class';
      diploma = 'Distinction';
    } else if (gpToDouble >= 3.5 && gpToDouble < 4.5) {
      degree = 'Second Class Upper';
      diploma = 'Credit';
    } else if (gpToDouble >= 2.4 && gpToDouble < 3.5) {
      degree = 'Second Class Lower';
      diploma = 'Merit';
    } else if (gpToDouble >= 1.5 && gpToDouble < 2.4) {
      degree = 'Third Class';
      diploma = 'Pass';
    } else if (gpToDouble >= 1.0 && gpToDouble < 1.5) {
      degree = 'Pass';
      diploma = 'Pass';
    } else if (gpToDouble >= 0 && gpToDouble < 1.0) {
      degree = 'Fail';
      diploma = 'Fail';
    } else {
      degree = '';
      diploma = '';
    }
    emit(
      GPCourseLoaded(
        courses: courses,
        cgpa: cgpa,
        degree: degree,
        diploma: diploma,
      ),
    );
  }

  void _updateCourse(UpdateGPCourse event, Emitter<GPCourseState> emit) async {
    emit(GPCourseLoading());
    _courseRepository.upDateCourse(event.course, event.id);
    List<GPCourse> courses = await _courseRepository.getAllGPCourses();
    String cgpa;
    String degree;
    String diploma;
    double totalPoints = 0.0;
    double totalUnits = 0.0;
    for (var course in courses) {
      totalUnits = totalUnits + course.creditUnit;
      totalPoints = totalPoints + course.points;
    }
    cgpa = (totalPoints / totalUnits).toStringAsFixed(2);
    final gpToDouble = double.parse(cgpa);
    if (gpToDouble > 4.5) {
      degree = 'First Class';
      diploma = 'Distinction';
    } else if (gpToDouble >= 3.5 && gpToDouble < 4.5) {
      degree = 'Second Class Upper';
      diploma = 'Credit';
    } else if (gpToDouble >= 2.4 && gpToDouble < 3.5) {
      degree = 'Second Class Lower';
      diploma = 'Merit';
    } else if (gpToDouble >= 1.5 && gpToDouble < 2.4) {
      degree = 'Third Class';
      diploma = 'Pass';
    } else if (gpToDouble >= 1.0 && gpToDouble < 1.5) {
      degree = 'Pass';
      diploma = 'Pass';
    } else if (gpToDouble >= 0 && gpToDouble < 1.0) {
      degree = 'Fail';
      diploma = 'Fail';
    } else {
      degree = '';
      diploma = '';
    }
    emit(
      GPCourseLoaded(
        courses: courses,
        cgpa: cgpa,
        degree: degree,
        diploma: diploma,
      ),
    );
  }

  void _clearAllRecord(ClearGPRecord event, Emitter<GPCourseState> emit) async {
    emit(GPCourseLoading());
    _courseRepository.clearAllRecord();
    List<GPCourse> courses = await _courseRepository.getAllGPCourses();
    String cgpa;
    String degree;
    String diploma;
    double totalPoints = 0.0;
    double totalUnits = 0.0;
    for (var course in courses) {
      totalUnits = totalUnits + course.creditUnit;
      totalPoints = totalPoints + course.points;
    }
    cgpa = (totalPoints / totalUnits).toStringAsFixed(2);
    final gpToDouble = double.parse(cgpa);
    if (gpToDouble > 4.5) {
      degree = 'First Class';
      diploma = 'Distinction';
    } else if (gpToDouble >= 3.5 && gpToDouble < 4.5) {
      degree = 'Second Class Upper';
      diploma = 'Credit';
    } else if (gpToDouble >= 2.4 && gpToDouble < 3.5) {
      degree = 'Second Class Lower';
      diploma = 'Merit';
    } else if (gpToDouble >= 1.5 && gpToDouble < 2.4) {
      degree = 'Third Class';
      diploma = 'Pass';
    } else if (gpToDouble >= 1.0 && gpToDouble < 1.5) {
      degree = 'Pass';
      diploma = 'Pass';
    } else if (gpToDouble >= 0 && gpToDouble < 1.0) {
      degree = 'Fail';
      diploma = 'Fail';
    } else {
      degree = '';
      diploma = '';
    }
    emit(
      GPCourseLoaded(
        courses: courses,
        cgpa: cgpa,
        degree: degree,
        diploma: diploma,
      ),
    );
  }

  void _clearYearRecord(
      ClearYearRecord event, Emitter<GPCourseState> emit) async {
    emit(GPCourseLoading());
    _courseRepository.clearYearRecord(event.year);
    List<GPCourse> courses = await _courseRepository.getAllGPCourses();
    String cgpa;
    String degree;
    String diploma;
    double totalPoints = 0.0;
    double totalUnits = 0.0;
    for (var course in courses) {
      totalUnits = totalUnits + course.creditUnit;
      totalPoints = totalPoints + course.points;
    }
    cgpa = (totalPoints / totalUnits).toStringAsFixed(2);
    final gpToDouble = double.parse(cgpa);
    if (gpToDouble > 4.5) {
      degree = 'First Class';
      diploma = 'Distinction';
    } else if (gpToDouble >= 3.5 && gpToDouble < 4.5) {
      degree = 'Second Class Upper';
      diploma = 'Credit';
    } else if (gpToDouble >= 2.4 && gpToDouble < 3.5) {
      degree = 'Second Class Lower';
      diploma = 'Merit';
    } else if (gpToDouble >= 1.5 && gpToDouble < 2.4) {
      degree = 'Third Class';
      diploma = 'Pass';
    } else if (gpToDouble >= 1.0 && gpToDouble < 1.5) {
      degree = 'Pass';
      diploma = 'Pass';
    } else if (gpToDouble >= 0 && gpToDouble < 1.0) {
      degree = 'Fail';
      diploma = 'Fail';
    } else {
      degree = '';
      diploma = '';
    }
    emit(
      GPCourseLoaded(
        courses: courses,
        cgpa: cgpa,
        degree: degree,
        diploma: diploma,
      ),
    );
  }

  void _clearSemester(
      ClearSemesterRecord event, Emitter<GPCourseState> emit) async {
    emit(GPCourseLoading());
    _courseRepository.clearSemesterRecord(event.year, event.semester);
    List<GPCourse> courses = await _courseRepository.getAllGPCourses();
    String cgpa;
    String degree;
    String diploma;
    double totalPoints = 0.0;
    double totalUnits = 0.0;
    for (var course in courses) {
      totalUnits = totalUnits + course.creditUnit;
      totalPoints = totalPoints + course.points;
    }
    cgpa = (totalPoints / totalUnits).toStringAsFixed(2);
    final gpToDouble = double.parse(cgpa);
    if (gpToDouble > 4.5) {
      degree = 'First Class';
      diploma = 'Distinction';
    } else if (gpToDouble >= 3.5 && gpToDouble < 4.5) {
      degree = 'Second Class Upper';
      diploma = 'Credit';
    } else if (gpToDouble >= 2.4 && gpToDouble < 3.5) {
      degree = 'Second Class Lower';
      diploma = 'Merit';
    } else if (gpToDouble >= 1.5 && gpToDouble < 2.4) {
      degree = 'Third Class';
      diploma = 'Pass';
    } else if (gpToDouble >= 1.0 && gpToDouble < 1.5) {
      degree = 'Pass';
      diploma = 'Pass';
    } else if (gpToDouble >= 0 && gpToDouble < 1.0) {
      degree = 'Fail';
      diploma = 'Fail';
    } else {
      degree = '';
      diploma = '';
    }
    emit(
      GPCourseLoaded(
        courses: courses,
        cgpa: cgpa,
        degree: degree,
        diploma: diploma,
      ),
    );
  }
}
