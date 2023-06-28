import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  int year;
  String? gpTarget;
  String? phone;
  String? school;
  String? name;
  UserData({this.year = 0, this.school, this.gpTarget, this.phone, this.name});

  UserData copyWith({
    int? year,
    String? gpTarget,
    String? phone,
    String? school,
    String? name,
  }) {
    return UserData(
      name: name ?? this.name,
      year: year ?? this.year,
      gpTarget: gpTarget ?? this.gpTarget,
      phone: phone ?? this.phone,
      school: school ?? this.school,
    );
  }

  static Map<String, dynamic> toMap(UserData user) {
    final result = <String, dynamic>{};

    result.addAll({'year': user.year});
    if (user.name != null) {
      result.addAll({'name': user.name});
    }
    if (user.gpTarget != null) {
      result.addAll({'gpTarget': user.gpTarget});
    }
    if (user.phone != null) {
      result.addAll({'phone': user.phone});
    }
    if (user.school != null) {
      result.addAll({'school': user.school});
    }

    return result;
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      year: map['year']?.toInt(),
      gpTarget: map['gpTarget']?.toDouble(),
      phone: map['phone']?.toInt(),
      school: map['school'],
      name: map['name'],
    );
  }
  @override
  List<Object?> get props => [year, gpTarget, phone, school];
}
