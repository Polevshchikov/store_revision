import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/core/usecases/usecase.dart';
import 'package:store_revision/feature/domain/entities/product_entity.dart';
import 'package:store_revision/feature/domain/repositories/product_repository.dart';
import 'package:store_revision/feature/domain/usecases/params/get_products_params.dart';

@injectable
class GetProductsUseCase
    extends UseCase<List<ProductEntity>, GetProductsParams> {
  final ProductRepository _productRepository;

  GetProductsUseCase(this._productRepository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(
      GetProductsParams params) async {
    final result =
        await _productRepository.getProducts(revisionId: params.revisionId);

    return result.fold(
        (failure) => Left(failure), (products) => Right(products));
  }
}
