import 'package:formz/formz.dart';

/// Validation errors for the [Email] [FormzInput].
enum RevisionDescrValidationError { empty }

class RevisionDescr extends FormzInput<String, RevisionDescrValidationError> {
  const RevisionDescr.pure() : super.pure('');

  const RevisionDescr.dirty([String value = '']) : super.dirty(value);

  @override
  RevisionDescrValidationError? validator(String? value) {
    return value?.isNotEmpty == true
        ? null
        : RevisionDescrValidationError.empty;
  }
}
