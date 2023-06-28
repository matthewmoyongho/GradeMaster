import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Assignment extends Equatable {
  String courseCode;
  String? title;
  String body;
  Timestamp dueDate;
  bool? isDone;
  String? lecture;
  String? docId;

  Assignment(
      {this.lecture,
      this.docId,
      required this.courseCode,
      required this.body,
      required this.dueDate,
      this.title,
      this.isDone}) {
    isDone = isDone ?? false;
    lecture = lecture ?? '';
    docId = docId ?? '';
    title = title ?? '';
  }
  void _setDone(bool state) {
    isDone = state;
  }

  // Future<void> toggleIsDone(String id) async {
  //   final oldState = isDone;
  //   isDone = !isDone!;
  //   try {
  //     await kMyGradeUsersCollection
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection('Assignments')
  //         .doc(id)
  //         .update({'isDone': !isDone});
  //     _setDone(isDone);
  //   } catch (e) {
  //     _setDone(oldState);
  //   }
  // }

  static Assignment fromSnapshot(DocumentSnapshot map) {
    return Assignment(
      courseCode: map['courseCode'] ?? '',
      title: map['title'],
      body: map['body'] ?? '',
      dueDate: map['dueDate'],
      isDone: map['isDone'] ?? false,
      lecture: map['lecture'],
      docId: map.id,
    );
  }

  // static Map<String, Object> toMap(Assignment assignment) {
  //   return {
  //     'courseCode': assignment.courseCode,
  //     'body': assignment.body,
  //     'dueDate': assignment.dueDate,
  //     'title': assignment.title!,
  //     'lecturer': assignment.lecture!,
  //     'isDone': assignment.isDone
  //   };
  // }

  Assignment copyWith({
    String? courseCode,
    String? title,
    String? body,
    Timestamp? dueDate,
    bool? isDone,
    String? lecture,
    String? docId,
  }) {
    return Assignment(
      courseCode: courseCode ?? this.courseCode,
      title: title ?? this.title,
      body: body ?? this.body,
      dueDate: dueDate ?? this.dueDate,
      isDone: isDone ?? this.isDone,
      lecture: lecture ?? this.lecture,
      docId: docId ?? this.docId,
    );
  }

  @override
  List<Object?> get props =>
      [courseCode, title, body, dueDate, isDone, lecture];

  static Map<String, dynamic> toMap(Assignment assignment) {
    final result = <String, dynamic>{};

    result.addAll({'courseCode': assignment.courseCode});
    if (assignment.title != null) {
      result.addAll({'title': assignment.title});
    }
    result.addAll({'body': assignment.body});
    result.addAll({'dueDate': assignment.dueDate});
    result.addAll({'isDone': assignment.isDone});
    if (assignment.lecture != null) {
      result.addAll({'lecture': assignment.lecture});
    }
    if (assignment.docId != null) {
      result.addAll({'docId': assignment.docId});
    }

    return result;
  }

  static toggleDone(Assignment assignment, bool done) {
    final result = <String, dynamic>{};

    result.addAll({'courseCode': assignment.courseCode});
    if (assignment.title != null) {
      result.addAll({'title': assignment.title});
    }
    result.addAll({'body': assignment.body});
    result.addAll({'dueDate': assignment.dueDate});
    result.addAll({'isDone': !done});
    if (assignment.lecture != null) {
      result.addAll({'lecture': assignment.lecture});
    }
    if (assignment.docId != null) {
      result.addAll({'docId': assignment.docId});
    }
    return result;
  }

  factory Assignment.fromMap(DocumentSnapshot map) {
    return Assignment(
      courseCode: map['courseCode'] ?? '',
      title: map['title'],
      body: map['body'] ?? '',
      dueDate: map['dueDate'],
      isDone: map['isDone'] ?? false,
      lecture: map['lecture'],
      docId: map.id,
    );
  }

//String toJson() => json.encode(toMap());

// factory Assignment.fromJson(String source) =>
//     Assignment.fromMap(json.decode(source));
}
