import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/entities/file_object.dart';
import 'package:store_revision/feature/domain/repositories/file_repository.dart';

@Injectable(as: FileRepository)
class FileRepositoryImpl implements FileRepository {
  FileRepositoryImpl();

  @override
  Future<Either<Failure, FileObject>> uploadFile(File file) async {
    final fileName = file.path.split('/').last;
    try {
      final _file =
          FileObject.initial(fileName, file.hashCode.toString(), file.path);
      return Right(_file);
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }
}
