import 'package:formz/formz.dart';

enum EmailInputValidator { invalid }

class EmailInput extends FormzInput<String, EmailInputValidator> {
  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty([String value = '']) : super.dirty(value);

  static final _validEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  EmailInputValidator? validator(String value) {
    return _validEmail.hasMatch(value) ? null : EmailInputValidator.invalid;
  }
}
