import 'package:formz/formz.dart';

enum NumValidationError { invalid }

class Num extends FormzInput<String, NumValidationError> {
  const Num.pure() : super.pure('');

  const Num.dirty([String value = '']) : super.dirty(value);

  static final RegExp _numRegExp = RegExp('[0-9.,]');
  @override
  NumValidationError? validator(String? value) {
    if (value != null) {
      int count = 0;
      for (var i = 0; i < value.length; i++) {
        if (value[i] == '.' || value[i] == ',') {
          count++;
        }
      }
      if (count > 1) {
        return NumValidationError.invalid;
      }
    }
    return _numRegExp.hasMatch(value ?? '') ? null : NumValidationError.invalid;
  }
}
