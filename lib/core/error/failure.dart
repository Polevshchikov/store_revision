import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class EmptyFailure extends Failure {
  const EmptyFailure() : super();

  String getLocalizedMessage() => '';
}

class UnknownFailure extends Failure {
  const UnknownFailure() : super();

  String getLocalizedMessage() => 'unknownFailure';
}

class NoChosenValueFailure extends Failure {
  const NoChosenValueFailure() : super();

  String getLocalizedMessage() => 'noChosenValueFailure';
}
