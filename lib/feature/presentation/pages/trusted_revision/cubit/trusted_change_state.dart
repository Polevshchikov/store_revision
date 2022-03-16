part of 'trusted_change_cubit.dart';

class TrustedChangeState extends Equatable {
  final List<UserEntity> users;
  final Status status;
  final Failure failure;

  const TrustedChangeState._({
    this.users = const [],
    this.status = Status.unknow,
    this.failure = const UnknownFailure(),
  });

  factory TrustedChangeState.initial() => const TrustedChangeState._();

  factory TrustedChangeState.loading() =>
      const TrustedChangeState._(status: Status.waiting);

  factory TrustedChangeState.success(List<UserEntity> users) =>
      TrustedChangeState._(
        status: Status.success,
        users: users,
      );

  factory TrustedChangeState.error(Failure failure) => TrustedChangeState._(
        status: Status.error,
        failure: failure,
      );

  @override
  List<Object> get props => [
        users,
        status,
        failure,
      ];
}
