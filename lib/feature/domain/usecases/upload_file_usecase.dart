import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/core/usecases/usecase.dart';
import 'package:store_revision/feature/domain/entities/file_object.dart';
import 'package:store_revision/feature/domain/repositories/file_repository.dart';
import 'package:store_revision/feature/domain/usecases/params/no_params.dart';

@injectable
class UploadFileUseCase extends UseCase<FileObject, NoParams> {
  final FileRepository _fileRepository;
  final ImagePicker _imagePicker;
  UploadFileUseCase(this._fileRepository, this._imagePicker);

  @override
  Future<Either<Failure, FileObject>> call(NoParams params) async {
    try {
      final pickedImage =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return const Left(NoChosenValueFailure());
      final result = await _fileRepository.uploadFile(File(pickedImage.path));
      return result.fold((failure) => Left(failure), (file) => Right(file));
    } on Exception {
      return const Left(UnknownFailure());
    }
  }
}
