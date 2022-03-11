import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/entities/revision_pdf.dart';

abstract class FilePDFRepository {
  Future<Either<Failure, File>> generatePDF({required RevisionPDF revisionPDF});
}
