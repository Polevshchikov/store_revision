part of 'change_body_cubit.dart';

class ChangeBodyState extends Equatable {
  final String revisionId;
  final String revisionName;
  final String revisionDescr;
  final BodyType bodyType;

  const ChangeBodyState._({
    this.revisionId = '',
    this.revisionName = '',
    this.revisionDescr = '',
    this.bodyType = BodyType.activeRevision,
  });

  factory ChangeBodyState.showTrustedAdd(String revisionId) =>
      ChangeBodyState._(revisionId: revisionId, bodyType: BodyType.trustedAdd);

  factory ChangeBodyState.showTrustedDelete(String revisionId) =>
      ChangeBodyState._(
          revisionId: revisionId, bodyType: BodyType.trustedDelete);

  factory ChangeBodyState.showActiveRevision() => const ChangeBodyState._();

  factory ChangeBodyState.showEditRevision(
          {required String revisionId,
          required String revisionName,
          required String revisionDescr}) =>
      ChangeBodyState._(
          revisionId: revisionId,
          revisionName: revisionName,
          revisionDescr: revisionDescr,
          bodyType: BodyType.editRevision);

  @override
  List<Object> get props => [revisionId, revisionDescr, revisionName];
}

enum BodyType {
  trustedAdd,
  trustedDelete,
  activeRevision,
  editRevision,
}
