import 'package:formz/formz.dart';

enum NumValidationError { invalid }

class Num extends FormzInput<String, NumValidationError> {
  const Num.pure() : super.pure('');

  const Num.dirty([String value = '']) : super.dirty(value);

  static final RegExp _serialNumRegExp = RegExp(r'[\d]{1,}$');

  @override
  NumValidationError? validator(String? value) {
    return _serialNumRegExp.hasMatch(value ?? '')
        ? null
        : NumValidationError.invalid;
  }
}
