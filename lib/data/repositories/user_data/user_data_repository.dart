import 'package:authentication_repository/src/models/user/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataRepository {
  String uid;
  FirebaseFirestore _firestore;

  UserDataRepository({
    //String? uid,
    FirebaseFirestore? firestore,
    required this.uid,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;
  // _uid = uid ?? FirebaseAuth.instance.currentUser!.uid;
  Future<UserData?> getUserData(String id) async {
    UserData? userData;

    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('Users').doc(id).get();
    if (snapshot.exists) {
      Map<String, dynamic>? data = snapshot.data();

      userData = UserData(
        year: data?['year'] ?? '',
        phone: data?['phone'] ?? '',
        gpTarget: data?['gpTarget'] ?? '',
        school: data?['school'] ?? '',
        name: data?['name'],
      );
    } else {
      userData = null;
    }
    return userData;
  }

  Future<void> updateUserData(UserData userData) async {
    await _firestore
        .collection('Users')
        .doc(uid)
        .update(UserData.toMap(userData));
  }

  Future<void> setUserData(String id, UserData userData) async {
    if (await getUserData(id) != null) return;
    await _firestore.collection('Users').doc(id).set(UserData.toMap(userData));
  }

  void updateYears(int currentYear) async {
    await _firestore
        .collection('Users')
        .doc(uid)
        .update({'year': currentYear + 1});
  }

  void resetYears() {
    _firestore.collection('Users').doc(uid).update({'year': 0});
  }
}
