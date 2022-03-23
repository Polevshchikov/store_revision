import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/core/usecases/usecase.dart';
import 'package:store_revision/feature/domain/usecases/params/no_params.dart';

@injectable
class UploadCameraImageUseCase extends UseCase<XFile, NoParams> {
  // final FileRepository _fileRepository;
  final ImagePicker _imagePicker;
  UploadCameraImageUseCase(this._imagePicker);

  @override
  Future<Either<Failure, XFile>> call(NoParams params) async {
    try {
      final pickedImage =
          await _imagePicker.pickImage(source: ImageSource.camera);
      if (pickedImage == null) return const Left(NoChosenValueFailure());
      // final result = await _fileRepository.uploadFile(pickedImage);
      return Right(pickedImage);
    } on Exception {
      return const Left(UnknownFailure());
    }
  }
}
