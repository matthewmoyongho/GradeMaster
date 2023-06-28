import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/time_table_course.dart';

class TimeTableRepository {
  final FirebaseFirestore _firestore;
  final String _uid;
  TimeTableRepository({FirebaseFirestore? firestore, String? uid})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _uid = uid ?? FirebaseAuth.instance.currentUser!.uid;

  Future<List<TimeTableCourse>> getAllTimeTableCourses() async {
    List<TimeTableCourse> courses = [];

    try {
      QuerySnapshot snapshot = await _firestore
          .collection('Users')
          .doc(_uid)
          .collection('TimeTable')
          .get();

      snapshot.docs.forEach((doc) {
        courses.add(TimeTableCourse.fromMap(doc));
      });
    } catch (e) {
      print('Operation failed');
    }
    return courses;
  }

  TimeTableCourse upDateTimetable(TimeTableCourse course, String id) {
    _firestore
        .collection('Users')
        .doc(_uid)
        .collection('TimeTable')
        .doc(id)
        .update(TimeTableCourse.toMap(course));
    return course;
  }

  void deleteTimetable(String id) {
    _firestore
        .collection('Users')
        .doc(_uid)
        .collection('TimeTable')
        .doc(id)
        .delete();
  }

  void addTimetable(TimeTableCourse course) {
    //TODO: Add a try catch block here
    _firestore
        .collection('Users')
        .doc(_uid)
        .collection('TimeTable')
        .add(TimeTableCourse.toMap(course));
  }
}
