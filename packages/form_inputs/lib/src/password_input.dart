import 'package:formz/formz.dart';

enum PasswordInputValidator { invalid }

class PasswordInput extends FormzInput<String, PasswordInputValidator> {
  const PasswordInput.pure() : super.pure('');
  const PasswordInput.dirty([String value = '']) : super.dirty(value);

  static final _validPassword =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  PasswordInputValidator? validator(String value) {
    return _validPassword.hasMatch(value)
        ? null
        : PasswordInputValidator.invalid;
  }
}
