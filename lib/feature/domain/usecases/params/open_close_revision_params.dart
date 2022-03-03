import 'package:equatable/equatable.dart';

class OpenCloseRevisionParams extends Equatable {
  final String revisionId;

  const OpenCloseRevisionParams({required this.revisionId});

  @override
  List<Object> get props => [
        revisionId,
      ];
}
