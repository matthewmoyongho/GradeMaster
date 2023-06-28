import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TimeTableCourse extends Equatable {
  String courseCode;
  String day;
  int startTime;
  int stopTime;
  String? title;
  String? docId;
  TimeTableCourse(
      {required this.courseCode,
      required this.day,
      required this.startTime,
      required this.stopTime,
      this.title,
      this.docId});

  TimeTableCourse copyWith(
    String? courseCode,
    String? day,
    int? startTime,
    int? stopTime,
    String? title,
    String? docId,
  ) {
    return TimeTableCourse(
        docId: docId != null ? docId : this.docId,
        courseCode: courseCode != null ? courseCode : this.courseCode,
        day: day != null ? day : this.day,
        startTime: startTime != null ? startTime : this.startTime,
        stopTime: stopTime != null ? stopTime : this.stopTime);
  }

  List<Object?> get props =>
      [courseCode, title, day, startTime, stopTime, docId];

  static Map<String, dynamic> toMap(TimeTableCourse timeTableCourse) {
    final result = <String, dynamic>{};

    result.addAll({'courseCode': timeTableCourse.courseCode});
    result.addAll({'day': timeTableCourse.day});
    result.addAll({'startTime': timeTableCourse.startTime});
    result.addAll({'endTime': timeTableCourse.stopTime});
    if (timeTableCourse.title != null) {
      result.addAll({'title': timeTableCourse.title});
    }
    if (timeTableCourse.docId != null) {
      result.addAll({'docId': timeTableCourse.docId});
    }
    return result;
  }

  factory TimeTableCourse.fromMap(DocumentSnapshot map) {
    return TimeTableCourse(
      courseCode: map['courseCode'] ?? '',
      day: map['day'] ?? '',
      startTime: map['startTime'] ?? '',
      stopTime: map['endTime'] ?? '',
      title: map['title'],
      docId: map.id,
    );
  }
}
