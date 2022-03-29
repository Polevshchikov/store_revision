part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final UserEntity user;
  final Failure error;

  const AuthenticationState._({
    this.status = AuthenticationStatus.initial,
    this.user = UserEntity.empty,
    Failure? error,
  }) : error = error ?? const EmptyFailure();

  const AuthenticationState.initial() : this._();

  const AuthenticationState.load() : this._(status: AuthenticationStatus.load);

  const AuthenticationState.error(Failure failure)
      : this._(status: AuthenticationStatus.error, error: failure);

  const AuthenticationState.authenticated({required UserEntity user})
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.noVerification({required UserEntity user})
      : this._(status: AuthenticationStatus.noVerification, user: user);

  const AuthenticationState.logOuted()
      : this._(status: AuthenticationStatus.unauthenticated);

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    UserEntity? user,
  }) {
    return AuthenticationState._(
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        status,
        user,
      ];
}

enum AuthenticationStatus {
  initial,
  authenticated,
  unauthenticated,
  noVerification,
  error,
  load
}
