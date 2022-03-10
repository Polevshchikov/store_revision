import 'package:equatable/equatable.dart';

class CreateProductParams extends Equatable {
  final String uid;
  final String revisionId;
  final String name;
  final String userName;
  final double cost;
  final double quantity;

  const CreateProductParams({
    required this.uid,
    required this.revisionId,
    required this.name,
    required this.userName,
    required this.cost,
    required this.quantity,
  });

  @override
  List<Object> get props => [
        uid,
        revisionId,
        name,
        userName,
        cost,
        quantity,
      ];
}
