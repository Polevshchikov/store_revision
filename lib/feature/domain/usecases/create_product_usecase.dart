import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/core/usecases/usecase.dart';
import 'package:store_revision/feature/domain/repositories/product_repository.dart';
import 'package:store_revision/feature/domain/usecases/params/create_product_params.dart';

@injectable
class CreateProductUseCase extends UseCase<void, CreateProductParams> {
  final ProductRepository _productRepository;

  CreateProductUseCase(this._productRepository);

  @override
  Future<Either<Failure, void>> call(CreateProductParams params) async {
    final result = await _productRepository.createProduct(
      cost: params.cost,
      uid: params.uid,
      count: params.count,
      name: params.name,
      revisionId: params.revisionId,
      userName: params.userName,
    );

    return result.fold(
        (failure) => Left(failure), (product) => const Right(null));
  }
}
