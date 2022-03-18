import 'package:equatable/equatable.dart';
import 'package:store_revision/feature/domain/entities/product_entity.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';

class RevisionInfoEntity extends Equatable {
  final List<ProductEntity> products;
  final List<UserEntity> users;

  const RevisionInfoEntity({
    required this.products,
    required this.users,
  });

  @override
  List<Object> get props => [
        users,
        products,
      ];
}
