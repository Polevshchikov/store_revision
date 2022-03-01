import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:store_revision/core/messages/messages.dart';
import 'package:store_revision/generated/l10n.dart';

abstract class Failure extends Equatable implements LocalizedMessage {
  const Failure();

  @override
  List<Object> get props => [];
}

class EmptyFailure extends Failure {
  const EmptyFailure() : super();

  @override
  String getLocalizedMessage(BuildContext context) => '';
}

class EmptyFieldFailure extends Failure {
  const EmptyFieldFailure() : super();

  @override
  String getLocalizedMessage(BuildContext context) =>
      S.of(context).emptyFieldFailure;
}

class NoChosenValueFailure extends Failure {
  const NoChosenValueFailure() : super();

  @override
  String getLocalizedMessage(BuildContext context) =>
      S.of(context).noChosenValueFailure;
}

class ConnectionFailure extends Failure {
  const ConnectionFailure() : super();

  @override
  String getLocalizedMessage(BuildContext context) =>
      S.of(context).connectionFailure;
}

class NoCachedDataFailure extends Failure {
  const NoCachedDataFailure() : super();

  @override
  String getLocalizedMessage(BuildContext context) =>
      S.of(context).noCachedDataFailure;
}

class CacheFailure extends Failure {
  const CacheFailure() : super();

  @override
  String getLocalizedMessage(BuildContext context) =>
      S.of(context).cacheFailure;
}

class UnknownFailure extends Failure {
  const UnknownFailure() : super();

  @override
  String getLocalizedMessage(BuildContext context) =>
      S.of(context).unknownFailure;
}

class SignUpWithEmailAndPasswordFailure extends Failure {
  final String statusCode;

  const SignUpWithEmailAndPasswordFailure(this.statusCode) : super();

  @override
  List<Object> get props => [statusCode];

  @override
  String getLocalizedMessage(BuildContext context) =>
      signUpfromCode(statusCode);
}

class LogInWithEmailAndPasswordFailure extends Failure {
  final String statusCode;

  const LogInWithEmailAndPasswordFailure(this.statusCode) : super();

  @override
  List<Object> get props => [statusCode];

  @override
  String getLocalizedMessage(BuildContext context) => logInfromCode(statusCode);
}

class LogInWithGoogleFailure extends Failure {
  final String statusCode;

  const LogInWithGoogleFailure(this.statusCode) : super();

  @override
  List<Object> get props => [statusCode];

  @override
  String getLocalizedMessage(BuildContext context) =>
      logInGooglefromCode(statusCode);
}

class LogOutFailure extends Failure {
  const LogOutFailure() : super();

  @override
  String getLocalizedMessage(BuildContext context) => S.of(context).logOut;
}

String signUpfromCode(String code) {
  switch (code) {
    case 'invalid-email':
      return 'Email is not valid or badly formatted.';
    case 'user-disabled':
      return 'This user has been disabled. Please contact support for help.';
    case 'email-already-in-use':
      return 'An account already exists for that email.';
    case 'operation-not-allowed':
      return 'Operation is not allowed.  Please contact support.';
    case 'weak-password':
      return 'Please enter a stronger password.';
    default:
      return 'Unknown Failure';
  }
}

String logInfromCode(String code) {
  switch (code) {
    case 'invalid-email':
      return 'Email is not valid or badly formatted.';
    case 'user-disabled':
      return 'This user has been disabled. Please contact support for help.';
    case 'user-not-found':
      return 'Email is not found, please create an account.';
    case 'wrong-password':
      return 'Incorrect password, please try again.';
    default:
      return 'Unknown Failure';
  }
}

String logInGooglefromCode(String code) {
  switch (code) {
    case 'account-exists-with-different-credential':
      return 'Account exists with different credentials.';
    case 'invalid-credential':
      return 'The credential received is malformed or has expired.';
    case 'operation-not-allowed':
      return 'Operation is not allowed.  Please contact support.';
    case 'user-disabled':
      return 'This user has been disabled. Please contact support for help.';
    case 'user-not-found':
      return 'Email is not found, please create an account.';
    case 'wrong-password':
      return 'Incorrect password, please try again.';
    case 'invalid-verification-code':
      return 'The credential verification code received is invalid.';
    case 'invalid-verification-id':
      return 'The credential verification ID received is invalid.';
    default:
      return 'Unknown Failure';
  }
}
