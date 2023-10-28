import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

class LoginState {
  final EmailInput emailInput;
  final PasswordInput passwordInput;
  final String? errorMessage;
  final FormzStatus status;
  bool showPassword;

  LoginState(
      {this.showPassword = true,
      this.status = FormzStatus.pure,
      this.passwordInput = const PasswordInput.pure(),
      this.emailInput = const EmailInput.pure(),
      this.errorMessage});

  LoginState copyWith(
      {bool? showPassword,
      EmailInput? emailInput,
      PasswordInput? passwordInput,
      String? errorMessage,
      FormzStatus? status}) {
    return LoginState(
      showPassword: showPassword ?? this.showPassword,
      status: status != null ? status : this.status,
      passwordInput: passwordInput != null ? passwordInput : this.passwordInput,
      emailInput: emailInput != null ? emailInput : this.emailInput,
      errorMessage: errorMessage != null ? errorMessage : this.errorMessage,
    );
  }
}
