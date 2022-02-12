import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/entities/file_object.dart';

abstract class FileRepository {
  Future<Either<Failure, FileObject>> uploadFile(File file);
}
