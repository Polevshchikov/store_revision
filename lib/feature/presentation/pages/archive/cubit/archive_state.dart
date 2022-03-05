part of 'archive_cubit.dart';

class ArchiveState extends Equatable {
  final List<RevisionEntity> revisions;
  final Status status;
  final Failure failure;

  const ArchiveState._({
    this.revisions = const [],
    this.status = Status.unknow,
    this.failure = const UnknownFailure(),
  });

  factory ArchiveState.initial() => const ArchiveState._();

  factory ArchiveState.loading() =>
      const ArchiveState._(status: Status.waiting);

  factory ArchiveState.success(List<RevisionEntity> revisions) =>
      ArchiveState._(
        status: Status.success,
        revisions: revisions,
      );

  factory ArchiveState.error(Failure failure) => ArchiveState._(
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
