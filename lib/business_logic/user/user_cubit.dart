import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/repositories/user_data/user_data_repository.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  String uid;
  late final FirebaseFirestore _firestore;
  UserDataRepository repository;
  UserCubit(
      {required this.uid,
      //String? uid,
      required this.repository})
      :
        // uid = uid ?? FirebaseAuth.instance.currentUser!.uid,
        super(UserState());
  void upDateUserDataState(UserState user) {
    _firestore = FirebaseFirestore.instance;
    _firestore.collection('User').doc(uid).set(UserState.toMap(user));
  }

  void loadUserData(String id) async {
    emit(
      state.copyWith(userDataState: UserDataStatus.userDataLoading),
    );
    UserData? user = await repository.getUserData(id);
    //TODO: Add try catch check
    emit(state.copyWith(
        name: user!.name,
        year: user.year,
        school: user.school,
        phone: user.phone!,
        gpTarget: user.gpTarget!,
        userDataState: UserDataStatus.userDataLoaded));
  }

  void setUserData(String id, UserData userData) async {
    emit(
      state.copyWith(userDataState: UserDataStatus.userDataLoading),
    );
    await repository.setUserData(id, userData);
    UserData? user = await repository.getUserData(id);
    emit(
      state.copyWith(
          name: user!.name,
          year: user.year,
          school: user.school,
          phone: user.phone!,
          gpTarget: user.gpTarget!,
          userDataState: UserDataStatus.userDataLoaded),
    );
  }

  void updateUserData(UserData userData, {String? id}) async {
    emit(
      state.copyWith(userDataState: UserDataStatus.userDataLoading),
    );
    await repository.updateUserData(userData);
    UserData? user = await repository.getUserData(id ?? uid);
    emit(state.copyWith(
        name: user!.name,
        year: user.year,
        school: user.school,
        phone: user.phone!,
        gpTarget: user.gpTarget!,
        userDataState: UserDataStatus.userDataLoaded));
  }

  void resetYear({String? id}) async {
    emit(
      state.copyWith(userDataState: UserDataStatus.userDataLoading),
    );
    repository.resetYears();
    UserData? user = await repository.getUserData(id ?? uid);
    emit(state.copyWith(
        name: user!.name,
        year: user.year,
        school: user.school,
        phone: user.phone!,
        gpTarget: user.gpTarget!,
        userDataState: UserDataStatus.userDataLoaded));
  }
}
