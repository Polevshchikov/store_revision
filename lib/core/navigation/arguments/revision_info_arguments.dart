import 'package:store_revision/feature/domain/entities/product_entity.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';

class RevisionInfoArguments {
  final RevisionEntity revision;
  final List<ProductEntity> products;

  const RevisionInfoArguments({
    required this.revision,
    required this.products,
  });
}
