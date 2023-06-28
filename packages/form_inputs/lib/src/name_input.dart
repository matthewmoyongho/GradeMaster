import 'package:formz/formz.dart';

enum NameInputValidator { invalid }

class NameInput extends FormzInput<String, NameInputValidator> {
  const NameInput.pure() : super.pure('');
  const NameInput.dirty([String value = '']) : super.dirty(value);

  static final _validName = RegExp(r"^(?!\s*$).+");
  // ^(?!\s*$).+   /(?!^$)([^\s])/
  @override
  NameInputValidator? validator(String value) {
    return _validName.hasMatch(value) ? null : NameInputValidator.invalid;
  }
}
