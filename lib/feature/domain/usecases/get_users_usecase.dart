import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/core/usecases/usecase.dart';
import 'package:store_revision/feature/domain/entities/user_entity.dart';
import 'package:store_revision/feature/domain/repositories/user_repository.dart';
import 'package:store_revision/feature/domain/usecases/params/no_params.dart';

@injectable
class GetUsersUseCase extends UseCase<List<UserEntity>, NoParams> {
  final UserRepository _userRepository;

  GetUsersUseCase(this._userRepository);

  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParams params) async {
    final result = await _userRepository.getAllUsers();

    return result.fold((failure) => Left(failure), (users) => Right(users));
  }
}
