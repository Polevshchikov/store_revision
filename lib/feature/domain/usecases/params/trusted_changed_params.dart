import 'package:equatable/equatable.dart';

class TrustedChangedParams extends Equatable {
  final List<String> trustedsId;
  final String revisionId;

  const TrustedChangedParams(
      {required this.trustedsId, required this.revisionId});

  @override
  List<Object> get props => [trustedsId, revisionId];
}
