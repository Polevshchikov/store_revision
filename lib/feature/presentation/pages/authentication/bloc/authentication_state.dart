part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final String appVersion;

  const AuthenticationState._({
    this.appVersion = '',
  });

  const AuthenticationState.initial() : this._();

  AuthenticationState copyWith({
    String? appVersion,
  }) {
    return AuthenticationState._(appVersion: appVersion ?? this.appVersion);
  }

  @override
  List<Object> get props => [appVersion];
}

enum AuthenticationStatus { initial, authenticated, unauthenticated, noVerification, error, load }
