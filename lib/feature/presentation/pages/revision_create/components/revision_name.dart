import 'package:formz/formz.dart';

/// Validation errors for the [Email] [FormzInput].
enum RevisionNameValidationError { empty }

class RevisionName extends FormzInput<String, RevisionNameValidationError> {
  const RevisionName.pure() : super.pure('');

  const RevisionName.dirty([String value = '']) : super.dirty(value);

  @override
  RevisionNameValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : RevisionNameValidationError.empty;
  }
}
