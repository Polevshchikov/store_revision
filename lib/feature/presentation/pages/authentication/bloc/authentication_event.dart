part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationInitialize extends AuthenticationEvent {}

class AuthenticationLoggedIn extends AuthenticationEvent {
  const AuthenticationLoggedIn(this.user);

  final UserEntity user;

  @override
  List<Object> get props => [user];
}

class AuthenticationLoggedOut extends AuthenticationEvent {}

class AuthenticationLoad extends AuthenticationEvent {}

class AuthenticationVerifivation extends AuthenticationEvent {
  const AuthenticationVerifivation(this.user);

  final UserEntity user;

  @override
  List<Object> get props => [user];
}

class AuthenticationLoggedError extends AuthenticationEvent {
  const AuthenticationLoggedError(this.failure);
  final Failure failure;

  @override
  List<Object> get props => [failure];
}
