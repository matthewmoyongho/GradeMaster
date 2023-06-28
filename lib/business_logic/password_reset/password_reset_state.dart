import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

class PasswordResetState {
  final EmailInput emailInput;

  final String? errorMessage;
  final FormzStatus status;

  PasswordResetState(
      {this.status = FormzStatus.pure,
      this.emailInput = const EmailInput.pure(),
      this.errorMessage});

  PasswordResetState copyWith(
      {EmailInput? emailInput, String? errorMessage, FormzStatus? status}) {
    return PasswordResetState(
      status: status ?? this.status,
      emailInput: emailInput ?? this.emailInput,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
