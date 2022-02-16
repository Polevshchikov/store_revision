import 'package:equatable/equatable.dart';
import 'package:store_revision/feature/domain/entities/product_entity.dart';

class RevisionEntity extends Equatable {
  final String id;
  final String uid;
  final String name;
  final String description;
  final List<ProductEntity> listProducts;
  final DateTime? date;
  final String creatorName;
  final bool isClosed;
  final double score;

  const RevisionEntity({
    required this.id,
    required this.uid,
    required this.name,
    required this.description,
    required this.listProducts,
    required this.date,
    required this.creatorName,
    required this.isClosed,
    required this.score,
  });

  /// Empty user which represents an unauthenticated user.
  static const empty = RevisionEntity(
    id: '',
    uid: '',
    name: '',
    description: '',
    listProducts: [],
    date: null,
    creatorName: '',
    isClosed: false,
    score: 0,
  );

  @override
  List<Object> get props => [
        id,
        uid,
        name,
        description,
        listProducts,
        creatorName,
        isClosed,
        score,
      ];
}
