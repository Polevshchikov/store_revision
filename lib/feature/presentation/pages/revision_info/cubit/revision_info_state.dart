part of 'revision_info_cubit.dart';

class RevisionInfoState extends Equatable {
  final RevisionInfoEntity revisionInfo;
  final Status status;
  final Failure failure;

  const RevisionInfoState._({
    this.revisionInfo = const RevisionInfoEntity(products: [], users: []),
    this.status = Status.unknow,
    this.failure = const UnknownFailure(),
  });

  factory RevisionInfoState.initial() => const RevisionInfoState._();

  factory RevisionInfoState.loading() =>
      const RevisionInfoState._(status: Status.waiting);

  factory RevisionInfoState.success(RevisionInfoEntity revisionInfo) =>
      RevisionInfoState._(
        status: Status.success,
        revisionInfo: revisionInfo,
      );

  factory RevisionInfoState.error(Failure failure) => RevisionInfoState._(
        status: Status.error,
        failure: failure,
      );

  @override
  List<Object> get props => [
        revisionInfo,
        status,
        failure,
      ];
}
