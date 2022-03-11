import 'package:equatable/equatable.dart';

class RevisionEntity extends Equatable {
  final String id;
  final String uid;
  final String name;
  final String description;
  final List<String> listTrusted;
  final List<String> listProducts;
  final DateTime date;
  final bool isClosed;
  final double total;

  const RevisionEntity({
    required this.id,
    required this.uid,
    required this.name,
    required this.description,
    required this.listTrusted,
    required this.listProducts,
    required this.date,
    required this.isClosed,
    required this.total,
  });

  @override
  List<Object> get props => [
        id,
        uid,
        date,
        name,
        description,
        listTrusted,
        listProducts,
        isClosed,
        total,
      ];
}
