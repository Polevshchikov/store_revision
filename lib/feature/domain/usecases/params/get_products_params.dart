import 'package:equatable/equatable.dart';

class GetProductsParams extends Equatable {
  final String revisionId;

  const GetProductsParams({
    required this.revisionId,
  });

  @override
  List<Object> get props => [
        revisionId,
      ];
}
