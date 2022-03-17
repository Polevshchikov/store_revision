part of 'revision_edit_cubit.dart';

class RevisionEditState extends Equatable {
  const RevisionEditState._({
    this.status = Status.unknow,
    this.failure = const UnknownFailure(),
  });

  final Status status;
  final Failure failure;

  factory RevisionEditState.initial() => const RevisionEditState._();

  factory RevisionEditState.loading() =>
      const RevisionEditState._(status: Status.waiting);

  factory RevisionEditState.success() =>
      const RevisionEditState._(status: Status.success);

  factory RevisionEditState.error(Failure failure) => RevisionEditState._(
        failure: failure,
        status: Status.error,
      );

  @override
  List<Object> get props => [status, failure];
}
