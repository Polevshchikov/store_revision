part of 'new_revision_cubit.dart';

class NewRevisionState extends Equatable {
  const NewRevisionState({
    this.name = const RevisionName.pure(),
    this.description = const RevisionDescr.pure(),
    this.creatorName = '',
    this.status = FormzStatus.pure,
    this.failure = const UnknownFailure(),
  });

  final RevisionName name;
  final RevisionDescr description;
  final String creatorName;
  final FormzStatus status;
  final Failure failure;

  @override
  List<Object> get props => [name, description, creatorName, status, failure];

  NewRevisionState copyWith({
    RevisionName? name,
    RevisionDescr? description,
    String? creatorName,
    FormzStatus? status,
    Failure? failure,
  }) {
    return NewRevisionState(
      name: name ?? this.name,
      description: description ?? this.description,
      creatorName: creatorName ?? this.creatorName,
      status: status ?? this.status,
      failure: failure ?? const UnknownFailure(),
    );
  }
}
