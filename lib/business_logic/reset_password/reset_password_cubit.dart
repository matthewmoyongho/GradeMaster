// import 'package:authentication_repository/authentication_repository.dart';
// import 'package:bloc/bloc.dart';
// import 'package:form_inputs/form_inputs.dart';
// import 'package:formz/formz.dart';
//
// import 'reset_password_state.dart';
//
// class ResetPasswordCubit extends Cubit<ResetPasswordState> {
//   ResetPasswordCubit(this._repository) : super(Reset_passwordState());
//   AuthenticationRepository _repository;
//   void emailChanged(String val) {
//     final email = EmailInput.dirty(val);
//     emit(
//       state.copyWith(
//         email: email,
//         status: Formz.validate([email]),
//       ),
//     );
//   }
//
//   Future resetPassword() async {
//     if (state.status.isInvalid) return;
//     emit(
//       state.copyWith(status: FormzStatus.submissionInProgress),
//     );
//     try {
//       await _repository.resetPassword(state.email.toString());
//       emit(state.copyWith(status: FormzStatus.submissionSuccess));
//     } catch (e) {
//       emit(
//         state.copyWith(status: FormzStatus.submissionFailure),
//       );
//     }
//   }
// }
