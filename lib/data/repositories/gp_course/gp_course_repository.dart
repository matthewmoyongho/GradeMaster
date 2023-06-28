import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/gp_course.dart';

class GPCourseRepository {
  final FirebaseFirestore _firestore;
  final String _uid;
  GPCourseRepository({FirebaseFirestore? firestore, String? uid})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _uid = uid ?? FirebaseAuth.instance.currentUser!.uid;
  Future<List<GPCourse>> getAllGPCourses() async {
    List<GPCourse> courses = [];
    try {
      print('Getting your GP Courses');
      QuerySnapshot snapshot = await _firestore
          .collection('Users')
          .doc(_uid)
          .collection('Years')
          .get();

      snapshot.docs.forEach((doc) {
        GPCourse course = GPCourse(
            grade: doc['grade'],
            points: doc['points'],
            code: doc['code'],
            creditUnit: doc['creditUnit'],
            year: doc['year'],
            semester: doc['semester'],
            title: doc['title'],
            id: doc.id);
        courses.add(course);
      });

      // DocumentSnapshot allCourses =
      //     snapshot.docs.map((doc) => doc.data()).toList();
      // allCourses.forEach((course) {
      //   courses.add(GPCourse.fromMap(course));
      // });

      print('Gotten your GP Courses and the length is ${courses.length}');
    } catch (e) {
      print('Operation failed');
    }

    return courses;
  }

  void upDateCourse(GPCourse course, String id) async {
    await _firestore
        .collection('Users')
        .doc(_uid)
        .collection('Years')
        .doc(id)
        .update(GPCourse.toMap(course));
  }

  void deleteCourse(String id) async {
    await _firestore
        .collection('Users')
        .doc(_uid)
        .collection('Years')
        .doc(id)
        .delete();
  }

  void addCourse(GPCourse course) async {
    await _firestore
        .collection('Users')
        .doc(_uid)
        .collection('Years')
        .add(GPCourse.toMap(course));
  }

  void clearSemesterRecord(String year, String semester) {
    _firestore
        .collection('Users')
        .doc(_uid)
        .collection('Years')
        .where('year', isEqualTo: year)
        .where('semester', isEqualTo: semester)
        .snapshots()
        .forEach((docs) {
      for (var doc in docs.docs) {
        doc.reference.delete();
      }
    });
  }

  void clearYearRecord(String year) {
    _firestore
        .collection('Users')
        .doc(_uid)
        .collection('Years')
        .where('year', isEqualTo: year)
        .snapshots()
        .forEach((docs) {
      for (var doc in docs.docs) {
        doc.reference.delete();
      }
    });
  }

  void clearAllRecord() {
    _firestore
        .collection('Users')
        .doc(_uid)
        .collection('Years')
        .snapshots()
        .forEach((document) {
      for (var doc in document.docs) {
        doc.reference.delete();
      }
    });
  }

  // void getSemesterGPA({required String year, required String semester}) {
  //   _firestore
  //       .collection('Users')
  //       .doc(_uid)
  //       .collection('Years')
  //       .where('year', isEqualTo: year)
  //       .where('semester', isEqualTo: semester)
  //       .snapshots();
  // }
  String getSemesterGPA({required String year, required String semester}) {
    double totalPoints = 0;
    double totalUnits = 0;
    _firestore
        .collection('Users')
        .doc(_uid)
        .collection('Years')
        .where('year', isEqualTo: year)
        .where('semester', isEqualTo: semester)
        .snapshots()
        .forEach((docs) {
      for (var doc in docs.docs) {
        totalPoints = totalPoints + doc['points'];
        totalUnits = totalUnits + doc['creditUit'];
      }
    });
    return (totalUnits / totalUnits).toStringAsFixed(2);
  }

  // void getYearGPA({required String year}) {
  //   // double totalPoints = 0;
  //   // double totalUnits = 0;
  //   _firestore
  //           .collection('Users')
  //           .doc(_uid)
  //           .collection('Years')
  //           .where('year', isEqualTo: year)
  //           .snapshots()
  //       //     .forEach((docs) {
  //       //   for (var doc in docs.docs) {
  //       //     totalPoints = totalPoints + doc['points'];
  //       //     totalUnits = totalUnits + doc['creditUit'];
  //       //   }
  //       // })
  //       ;
  //   //return (totalUnits / totalUnits).toStringAsFixed(2);
  // }

  String getYearGPA({required String year}) {
    double totalPoints = 0;
    double totalUnits = 0;
    _firestore
        .collection('Users')
        .doc(_uid)
        .collection('Years')
        .where('year', isEqualTo: year)
        .snapshots()
        .forEach((docs) {
      for (var doc in docs.docs) {
        totalPoints = totalPoints + doc['points'];
        totalUnits = totalUnits + doc['creditUit'];
      }
    });
    return (totalUnits / totalUnits).toStringAsFixed(2);
  }

  String getCGPA() {
    double totalPoints = 0;
    double totalUnits = 0;
    _firestore
        .collection('Users')
        .doc(_uid)
        .collection('Years')
        .snapshots()
        .forEach((docs) {
      for (var doc in docs.docs) {
        totalPoints = totalPoints + doc['points'];
        totalUnits = totalUnits + doc['creditUit'];
      }
    });
    return (totalUnits / totalUnits).toStringAsFixed(2);
  }
}
