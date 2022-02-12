part of 'revision_cubit.dart';

abstract class RevisionState extends Equatable {
  const RevisionState();

  @override
  List<Object> get props => [];
}

class RevisionInitial extends RevisionState {}
