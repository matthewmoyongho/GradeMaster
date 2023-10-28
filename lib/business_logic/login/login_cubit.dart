import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(LoginState());

  AuthenticationRepository _authenticationRepository;

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

  void updateShowPassword() {
    emit(state.copyWith(
      showPassword: !state.showPassword,
      status: Formz.validate(
        [state.passwordInput, state.emailInput],
      ),
    ));
  }

  Future login() async {
    if (state.status.isInvalid) return;
    emit(
      state.copyWith(status: FormzStatus.submissionInProgress),
    );
    try {
      await _authenticationRepository.login(
          state.emailInput.value.trim(), state.passwordInput.value.trim());
      emit(
        state.copyWith(status: FormzStatus.submissionSuccess),
      );
    } on LogInWithEmailAndPasswordError catch (e) {
      emit(
        state.copyWith(
            errorMessage: e.message, status: FormzStatus.submissionFailure),
      );
    } catch (_) {
      emit(
        state.copyWith(status: FormzStatus.submissionFailure),
      );
    }
  }

  Future<firebase_auth.User?> googleSignIn() async {
    firebase_auth.User? userDetails;
    emit(
      state.copyWith(status: FormzStatus.submissionInProgress),
    );

    try {
      userDetails = await _authenticationRepository.googleLogin();
      emit(
        state.copyWith(status: FormzStatus.submissionSuccess),
      );
    } on LogInWithGoogleError catch (e) {
      emit(
        state.copyWith(
            errorMessage: e.errorMessage,
            status: FormzStatus.submissionFailure),
      );
    } catch (_) {
      emit(
        state.copyWith(status: FormzStatus.submissionFailure),
      );
    }
    return userDetails;
  }
}
