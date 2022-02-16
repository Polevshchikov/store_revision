import 'package:dartz/dartz.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/core/usecases/usecase.dart';
import 'package:store_revision/feature/domain/repositories/revision_repository.dart';
import 'package:store_revision/feature/domain/repositories/user_repository.dart';
import 'package:store_revision/feature/domain/usecases/params/create_revision_params.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateRevisionUseCase extends UseCase<void, CreateRevisionParams> {
  final RevisionRepository _revisionRepository;
  final UserRepository _userRepository;

  CreateRevisionUseCase(this._revisionRepository, this._userRepository);

  @override
  Future<Either<Failure, void>> call(CreateRevisionParams params) async {
    final result = await _revisionRepository.createRevision(
      uid: params.uid,
      name: params.name,
      description: params.description,
      username: params.username,
    );

    return result.fold((failure) => Left(failure), (revisionRemote) async {
      final result = await _userRepository.changeRevisionUser(
          uid: params.uid, revisionId: revisionRemote.id);

      return result.fold(
          (failure) => Left(failure), (revision) => Right(revision));
    });
  }
}
