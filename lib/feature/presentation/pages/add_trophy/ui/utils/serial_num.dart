import 'package:formz/formz.dart';

enum SerialNumValidationError { invalid }

class SerialNum extends FormzInput<String, SerialNumValidationError> {
  const SerialNum.pure() : super.pure('');

  const SerialNum.dirty([String value = '']) : super.dirty(value);

  static final RegExp _serialNumRegExp = RegExp(r'[\d]{12,}$');

  @override
  SerialNumValidationError? validator(String? value) {
    return _serialNumRegExp.hasMatch(value ?? '')
        ? null
        : SerialNumValidationError.invalid;
  }
}
