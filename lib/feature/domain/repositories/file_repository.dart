import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_revision/core/error/failure.dart';

abstract class FileRepository {
  Future<Either<Failure, String>> uploadFile(XFile file);
}
