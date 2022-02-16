import 'package:equatable/equatable.dart';

class DeleteRevisionParams extends Equatable {
  final String revisionId;

  const DeleteRevisionParams({required this.revisionId});

  @override
  List<Object> get props => [revisionId];
}
