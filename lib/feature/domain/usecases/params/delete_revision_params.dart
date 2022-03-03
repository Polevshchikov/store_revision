import 'package:equatable/equatable.dart';

class DeleteRevisionParams extends Equatable {
  final String revisionId;
  final String userId;

  const DeleteRevisionParams({required this.revisionId, required this.userId});

  @override
  List<Object> get props => [revisionId, userId];
}
