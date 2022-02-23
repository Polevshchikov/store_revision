import 'package:equatable/equatable.dart';

class CreateProductParams extends Equatable {
  final String uid;
  final String revisionId;
  final String name;
  final String userName;
  final String cost;
  final String count;

  const CreateProductParams({
    required this.uid,
    required this.revisionId,
    required this.name,
    required this.userName,
    required this.cost,
    required this.count,
  });

  @override
  List<Object> get props => [
        uid,
        revisionId,
        name,
        userName,
        cost,
        count,
      ];
}
