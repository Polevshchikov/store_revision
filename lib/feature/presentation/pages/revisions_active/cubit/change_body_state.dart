part of 'change_body_cubit.dart';

abstract class ChangeBodyState extends Equatable {
  const ChangeBodyState();

  @override
  List<Object> get props => [];
}

class ShowTrustedAddState extends ChangeBodyState {}

class ShowActiveRevisionState extends ChangeBodyState {}

class ShowEditRevisionState extends ChangeBodyState {}
