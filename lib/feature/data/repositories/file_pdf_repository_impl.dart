import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/api/pdf_revision_api.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/entities/revision_pdf.dart';
import 'package:store_revision/feature/domain/repositories/file_pdf_repository.dart';

@Injectable(as: FilePDFRepository)
class FilePDFRepositoryImpl implements FilePDFRepository {
  FilePDFRepositoryImpl();

  @override
  Future<Either<Failure, File>> generatePDF(
      {required RevisionPDF revisionPDF}) async {
    try {
      final pdfFile = await PdfRevisionApi.generate(revisionPDF);
      return Right(pdfFile);
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }
}
