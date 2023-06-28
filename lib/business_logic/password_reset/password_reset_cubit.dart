import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:my_acad/business_logic/password_reset/password_reset_state.dart';

class PasswordResetCubit extends Cubit<PasswordResetState> {
  PasswordResetCubit(this._repository) : super(PasswordResetState());
  AuthenticationRepository _repository;
  void emailChanged(String val) {
    final email = EmailInput.dirty(val);
    emit(
      state.copyWith(
        emailInput: email,
        status: Formz.validate([email]),
      ),
    );
  }

  Future resetPassword() async {
    if (state.status.isInvalid) return;
    emit(
      state.copyWith(status: FormzStatus.submissionInProgress),
    );
    try {
      await _repository.resetPassword(state.emailInput.toString());
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(
        state.copyWith(status: FormzStatus.submissionFailure),
      );
    }
  }
}
