import 'package:equatable/equatable.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';

class OpenRevisionPDFParams extends Equatable {
  final RevisionEntity revision;

  const OpenRevisionPDFParams({required this.revision});

  @override
  List<Object> get props => [revision];
}
