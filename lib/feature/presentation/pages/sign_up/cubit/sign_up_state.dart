part of 'sign_up_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class SignUpState extends Equatable {
  const SignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.username = const Username.pure(),
    this.status = FormzStatus.pure,
    this.error = const EmptyFailure(),
  });

  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final Username username;
  final FormzStatus status;
  final Failure error;

  @override
  List<Object> get props => [
        email,
        password,
        confirmedPassword,
        status,
        username,
        error,
      ];

  SignUpState copyWith({
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    Username? username,
    FormzStatus? status,
    Failure? error,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      username: username ?? this.username,
      status: status ?? this.status,
      error: error ?? const EmptyFailure(),
    );
  }
}
