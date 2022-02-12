import 'package:formz/formz.dart';

/// Validation errors for the [Email] [FormzInput].
enum UsernameValidationError {
  /// Generic invalid error.
  invalid
}

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');

  const Username.dirty([String value = '']) : super.dirty(value);

  final String username = '';

  @override
  UsernameValidationError? validator(String? value) {
    return username == value ? null : UsernameValidationError.invalid;
  }
}
