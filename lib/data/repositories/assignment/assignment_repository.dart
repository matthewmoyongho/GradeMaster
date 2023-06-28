import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/assignment.dart';

class AssignmentRepository {
  final FirebaseFirestore _firestore;
  String _uid;
  AssignmentRepository({FirebaseFirestore? firestore, String? uid})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _uid = uid ?? FirebaseAuth.instance.currentUser!.uid;

  Future<List<Assignment>> getAllAssignment() async {
    List<Assignment> assignments = [];

    try {
      QuerySnapshot snapshot = await _firestore
          .collection('Users')
          .doc(_uid)
          .collection('Assignments')
          .get();

      snapshot.docs.forEach((doc) {
        assignments.add(Assignment.fromMap(doc));
      });
    } catch (e) {
      print('Operation failed');
    }

    return assignments;
  }

  Assignment upDateAssignment(Assignment assignment) {
    _firestore
        .collection('Users')
        .doc(_uid)
        .collection('Assignments')
        .doc(assignment.docId)
        .update(Assignment.toMap(assignment));
    return assignment;
  }

  Assignment toggleDose(Assignment assignment, String id, bool done) {
    _firestore
        .collection('Users')
        .doc(_uid)
        .collection('Assignments')
        .doc(id)
        .update(Assignment.toggleDone(assignment, done));
    return assignment;
  }

  void deleteAssignment(Assignment assignment, String id) {
    _firestore
        .collection('Users')
        .doc(_uid)
        .collection('Assignments')
        .doc(id)
        .delete();
  }

  Future<void> addAssignment(Assignment assignment) async {
    //TODO: Add a try catch block here
    print('started ass rep');
    try {
      await _firestore
          .collection('Users')
          .doc(_uid)
          .collection('Assignments')
          .add(Assignment.toMap(assignment));
    } catch (e) {
      rethrow;
    }
  }
}
