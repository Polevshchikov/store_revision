part of 'revision_active_list_cubit.dart';

class RevisionActiveListState extends Equatable {
  final List<RevisionEntity> revisions;
  final Status status;
  final Failure failure;

  const RevisionActiveListState._({
    this.revisions = const [],
    this.status = Status.unknow,
    this.failure = const UnknownFailure(),
  });

  factory RevisionActiveListState.initial() =>
      const RevisionActiveListState._();

  factory RevisionActiveListState.loading() =>
      const RevisionActiveListState._(status: Status.waiting);

  factory RevisionActiveListState.success(List<RevisionEntity> revisions) =>
      RevisionActiveListState._(
        status: Status.success,
        revisions: revisions,
      );

  factory RevisionActiveListState.error(Failure failure) =>
      RevisionActiveListState._(
        status: Status.error,
        failure: failure,
      );

  @override
  List<Object> get props => [
        revisions,
        status,
        failure,
      ];
}
