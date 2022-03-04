import 'package:dartz/dartz.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/core/usecases/usecase.dart';
import 'package:store_revision/feature/domain/entities/product_entity.dart';
import 'package:store_revision/feature/domain/repositories/product_repository.dart';
import 'package:store_revision/feature/domain/repositories/revision_repository.dart';
import 'package:store_revision/feature/domain/usecases/params/delete_product_params.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteProductsUseCase
    extends UseCase<List<ProductEntity>, DeleteProductParams> {
  final RevisionRepository _revisionRepository;
  final ProductRepository _productRepository;

  DeleteProductsUseCase(this._revisionRepository, this._productRepository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(
      DeleteProductParams params) async {
    final resultProduct = await _productRepository.daleteProduct(
        revisionId: params.revisionId, productId: params.product.id);

    return resultProduct.fold((failure) => Left(failure), (products) async {
      final resultRevisoionDelProd =
          await _revisionRepository.deleteProductRevision(
              revisionId: params.revisionId, product: params.product);

      return resultRevisoionDelProd.fold((failure) => Left(failure),
          (product) async {
        final resultProductsRevision =
            await _productRepository.getProducts(revisionId: params.revisionId);

        return resultProductsRevision.fold(
            (failure) => Left(failure), (products) => Right(products));
      });
    });
  }
}
