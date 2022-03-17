import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/core/usecases/usecase.dart';
import 'package:store_revision/feature/domain/repositories/product_repository.dart';
import 'package:store_revision/feature/domain/usecases/params/edit_product_params.dart';

@injectable
class EditProductUseCase extends UseCase<void, EditProductParams> {
  final ProductRepository _productRepository;

  EditProductUseCase(this._productRepository);

  @override
  Future<Either<Failure, void>> call(EditProductParams params) async {
    final result = await _productRepository.editProduct(
      revisionId: params.revisionId,
      productId: params.productId,
      productName: params.productName,
      productCost: params.productCost,
      productQuantity: params.productQuantity,
    );

    return result.fold((failure) => Left(failure), (_) => Right(_));
  }
}
