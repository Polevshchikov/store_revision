import 'package:hive/hive.dart';
import 'package:store_revision/feature/data/models/local/product_local_model.dart';
import 'package:store_revision/feature/domain/entities/product_entity.dart';

part 'products_cache_local_model.g.dart';

const productsCacheBoxKey = 'productsCacheBox';

@HiveType(typeId: 4)
class ProductsCacheLocalModel {
  @HiveField(0)
  final List<ProductLocalModel> products;
  @HiveField(1)
  final String createdAt;

  ProductsCacheLocalModel(
    this.products,
    this.createdAt,
  );

  factory ProductsCacheLocalModel.from(List<ProductEntity> products) =>
      ProductsCacheLocalModel(
        products.map((product) => ProductLocalModel.from(product)).toList(),
        DateTime.now().toIso8601String(),
      );
}
