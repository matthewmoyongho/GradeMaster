import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class GPCourse extends Equatable {
  String code;
  String? title;
  String grade;
  int creditUnit;
  String? id;
  String year;
  String semester;
  int points;
  GPCourse(
      {required this.grade,
      required this.points,
      required this.code,
      this.title,
      required this.creditUnit,
      this.id,
      required this.year,
      required this.semester});

  GPCourse copyWith(
    String? code,
    String? title,
    String? grade,
    int? creditUnit,
    String? id,
    String? year,
    String? semester,
    int? points,
  ) {
    return GPCourse(
        grade: grade != null ? grade : this.grade,
        points: points != null ? points : this.points,
        code: code != null ? code : this.code,
        creditUnit: creditUnit != null ? creditUnit : this.creditUnit,
        year: year != null ? year : this.year,
        semester: semester != null ? semester : this.semester,
        title: title != null ? title : title,
        id: id != null ? id : this.id);
  }

  static GPCourse fromSnapshot(DocumentSnapshot snapshot) {
    return GPCourse(
      code: snapshot['code'] ?? '',
      title: snapshot['title'],
      grade: snapshot['grade'] ?? '',
      creditUnit: snapshot['creditUnit']?.toInt() ?? 0,
      id: snapshot['id'],
      year: snapshot['year'] ?? '',
      semester: snapshot['semester'] ?? '',
      points: snapshot['points']?.toInt() ?? 0,
    );
  }

  // static Map toMap(GPCourse course) {
  //   return {
  //     'grade': course.grade,
  //     'points': course.points,
  //     'code': course.code,
  //     'creditUnit': course.creditUnit,
  //     'year': course.year,
  //     'semester': course.semester,
  //     'title': course.title
  //   };
  // }

  @override
  List<Object?> get props => [
        code,
        title,
        grade,
        creditUnit,
        id,
        year,
        semester,
        points,
      ];

  static Map<String, dynamic> toMap(GPCourse course) {
    final result = <String, dynamic>{};

    result.addAll({'code': course.code});
    if (course.title != null) {
      result.addAll({'title': course.title});
    }
    result.addAll({'grade': course.grade});
    result.addAll({'creditUnit': course.creditUnit});
    if (course.id != null) {
      result.addAll({'id': course.id});
    }
    result.addAll({'year': course.year});
    result.addAll({'semester': course.semester});
    result.addAll({'points': course.points});

    return result;
  }

  factory GPCourse.fromMap(DocumentSnapshot map) {
    return GPCourse(
      code: map['code'] ?? '',
      title: map['title'],
      grade: map['grade'] ?? '',
      creditUnit: map['creditUnit']?.toInt() ?? 0,
      id: map.id,
      year: map['year'] ?? '',
      semester: map['semester'] ?? '',
      points: map['points']?.toInt() ?? 0,
    );
  }
}
