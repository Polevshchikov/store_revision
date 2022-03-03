import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/core/usecases/usecase.dart';
import 'package:store_revision/feature/domain/repositories/product_repository.dart';
import 'package:store_revision/feature/domain/repositories/revision_repository.dart';
import 'package:store_revision/feature/domain/usecases/params/create_product_params.dart';

@injectable
class CreateProductUseCase extends UseCase<void, CreateProductParams> {
  final ProductRepository _productRepository;
  final RevisionRepository _revisionRepository;

  CreateProductUseCase(this._productRepository, this._revisionRepository);

  @override
  Future<Either<Failure, void>> call(CreateProductParams params) async {
    final result = await _productRepository.createProduct(
      uid: params.uid,
      revisionId: params.revisionId,
      name: params.name,
      userName: params.userName,
      cost: params.cost,
      count: params.count,
    );

    return result.fold((failure) => Left(failure), (productRemote) async {
      final result = await _revisionRepository.addProductRevision(
          revisionId: params.revisionId, product: productRemote);

      return result.fold(
          (failure) => Left(failure), (product) => const Right(null));
    });
  }
}
