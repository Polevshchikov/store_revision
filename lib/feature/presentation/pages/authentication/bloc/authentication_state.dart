part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final bool isAuth;
  final UserEntity user;
  final Failure error;

  const AuthenticationState._({
    this.status = AuthenticationStatus.initial,
    this.isAuth = true,
    this.user = UserEntity.empty,
    Failure? error,
  }) : error = error ?? const EmptyFailure();

  const AuthenticationState.initial() : this._();

  const AuthenticationState.load() : this._(status: AuthenticationStatus.load);

  const AuthenticationState.error(Failure failure)
      : this._(status: AuthenticationStatus.error, error: failure);

  const AuthenticationState.authenticated({required UserEntity user})
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated, isAuth: true);

  const AuthenticationState.logOuted()
      : this._(status: AuthenticationStatus.unauthenticated, isAuth: true);

  @override
  List<Object> get props => [
        status,
        user,
        isAuth,
      ];
}

enum AuthenticationStatus {
  initial,
  authenticated,
  unauthenticated,
  error,
  load
}
