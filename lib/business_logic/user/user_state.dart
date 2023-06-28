enum UserDataStatus { userDataLoading, userDataLoaded }

class UserState {
  String? name;
  int year;
  String? gpTarget;
  String? phone;
  String? school;
  UserDataStatus? userDataStatus;

  UserState(
      {this.name,
      this.year = 0,
      this.school,
      this.gpTarget,
      this.phone,
      this.userDataStatus});

  UserState copyWith({
    String? name,
    int? year,
    String? gpTarget,
    String? phone,
    String? school,
    UserDataStatus? userDataState,
  }) {
    return UserState(
      name: name ?? this.name,
      userDataStatus: userDataStatus ?? UserDataStatus.userDataLoading,
      year: year ?? this.year,
      gpTarget: gpTarget ?? this.gpTarget,
      phone: phone ?? this.phone,
      school: school ?? this.school,
    );
  }

  static Map<String, dynamic> toMap(UserState user) {
    final result = <String, dynamic>{};

    if (user.year != null) {
      result.addAll({'year': user.year});
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

  factory UserState.fromMap(Map<String, dynamic> map) {
    return UserState(
      year: map['year']?.toInt(),
      gpTarget: map['gpTarget']?.toInt(),
      phone: map['phone']?.toInt(),
      school: map['school'],
    );
  }
}
