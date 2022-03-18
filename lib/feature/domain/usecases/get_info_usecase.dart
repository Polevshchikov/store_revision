import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/core/usecases/usecase.dart';
import 'package:store_revision/feature/domain/entities/revision_info_entity.dart';
import 'package:store_revision/feature/domain/repositories/product_repository.dart';
import 'package:store_revision/feature/domain/repositories/user_repository.dart';
import 'package:store_revision/feature/domain/usecases/params/get_info_params.dart';

@injectable
class GetInfoUseCase extends UseCase<RevisionInfoEntity, GetInfoParams> {
  final ProductRepository _productRepository;
  final UserRepository _userRepository;
  GetInfoUseCase(this._productRepository, this._userRepository);

  @override
  Future<Either<Failure, RevisionInfoEntity>> call(GetInfoParams params) async {
    final resultProducts =
        await _productRepository.getProducts(revisionId: params.revisionId);

    return resultProducts.fold((failure) => Left(failure),
        (listProducts) async {
      final resultUsers = await _userRepository.getAllUsers();

      return resultUsers.fold((failure) => Left(failure), (users) async {
        final listUsers = users
            .where((e1) => !params.trustedsId.every((e2) => e1.uid != e2))
            .toList();
        final revisionInfo =
            RevisionInfoEntity(products: listProducts, users: listUsers);
        return Right(revisionInfo);
      });
    });
  }
}
