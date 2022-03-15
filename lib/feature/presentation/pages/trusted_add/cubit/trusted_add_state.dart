part of 'trusted_add_cubit.dart';

class TrustedAddState extends Equatable {
  final List<UserEntity> users;
  final Status status;
  final Failure failure;

  const TrustedAddState._({
    this.users = const [],
    this.status = Status.unknow,
    this.failure = const UnknownFailure(),
  });

  factory TrustedAddState.initial() => const TrustedAddState._();

  factory TrustedAddState.loading() =>
      const TrustedAddState._(status: Status.waiting);

  factory TrustedAddState.success(List<UserEntity> users) => TrustedAddState._(
        status: Status.success,
        users: users,
      );

  factory TrustedAddState.error(Failure failure) => TrustedAddState._(
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
