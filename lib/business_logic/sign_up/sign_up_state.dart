import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

class SignUpState {
  final PasswordInput passwordInput;
  final NameInput nameInput;
  final EmailInput emailInput;
  final String? errorMessage;
  final FormzStatus status;
  final bool showPassword;

  const SignUpState(
      {this.nameInput = const NameInput.pure(),
      this.status = FormzStatus.pure,
      this.emailInput = const EmailInput.pure(),
      this.passwordInput = const PasswordInput.pure(),
      this.showPassword = false,
      this.errorMessage});

  SignUpState copyWith({
    NameInput? nameInput,
    PasswordInput? passwordInput,
    EmailInput? emailInput,
    String? errorMessage,
    bool? showPassword,
    FormzStatus? status,
  }) {
    return SignUpState(
      nameInput: nameInput ?? this.nameInput,
      passwordInput: passwordInput != null ? passwordInput : this.passwordInput,
      status: status != null ? status : this.status,
      errorMessage: errorMessage != null ? errorMessage : this.errorMessage,
      emailInput: emailInput != null ? emailInput : this.emailInput,
      showPassword: showPassword != null ? showPassword : this.showPassword,
    );
  }
}
