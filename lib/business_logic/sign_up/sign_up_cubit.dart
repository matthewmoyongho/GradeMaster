import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:my_acad/business_logic/sign_up/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authenticationRepository) : super(SignUpState());
  final AuthenticationRepository _authenticationRepository;

  void nameChanged(String value) {
    final name = NameInput.dirty(value);
    emit(
      state.copyWith(
        nameInput: name,
        status: Formz.validate([name, state.emailInput, state.passwordInput]),
      ),
    );
  }

  void updateShowPassword() {
    emit(state.copyWith(
      showPassword: !state.showPassword,
      status: Formz.validate(
        [state.passwordInput, state.emailInput],
      ),
    ));
  }

  void emailChanged(String value) {
    final email = EmailInput.dirty(value);
    emit(
      state.copyWith(
        emailInput: email,
        status: Formz.validate([email, state.passwordInput]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = PasswordInput.dirty(value);
    emit(
      state.copyWith(
        passwordInput: password,
        status: Formz.validate([password, state.emailInput]),
      ),
    );
  }

  Future<firebase_auth.User?> singUp() async {
    firebase_auth.User? fbUser;
    if (state.status.isInvalid) return null;
    emit(
      state.copyWith(status: FormzStatus.submissionInProgress),
    );
    try {
      fbUser = await _authenticationRepository.signUp(
          state.emailInput.value.trim(), state.passwordInput.value.trim());
      emit(
        state.copyWith(status: FormzStatus.submissionSuccess),
      );
    } on SignUpWithEmailAndPasswordError catch (e) {
      emit(
        state.copyWith(
            errorMessage: e.message, status: FormzStatus.submissionFailure),
      );
    } catch (_) {
      emit(
        state.copyWith(status: FormzStatus.submissionFailure),
      );
    }
    return fbUser;
  }
}
