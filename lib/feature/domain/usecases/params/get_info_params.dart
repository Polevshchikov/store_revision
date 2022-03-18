import 'package:equatable/equatable.dart';

class GetInfoParams extends Equatable {
  final String revisionId;
  final List<String> trustedsId;

  const GetInfoParams({
    required this.revisionId,
    required this.trustedsId,
  });

  @override
  List<Object> get props => [revisionId, trustedsId];
}
