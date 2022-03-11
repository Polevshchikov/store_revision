import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/core/usecases/usecase.dart';
import 'package:store_revision/feature/domain/entities/revision_pdf.dart';
import 'package:store_revision/feature/domain/repositories/file_pdf_repository.dart';
import 'package:store_revision/feature/domain/repositories/product_repository.dart';

import 'package:store_revision/feature/domain/usecases/params/open_revision_pdf_params.dart';

@injectable
class OpenRevisionPDFUseCase extends UseCase<File, OpenRevisionPDFParams> {
  final FilePDFRepository _filePDFRepository;
  final ProductRepository _productRepository;
  OpenRevisionPDFUseCase(this._filePDFRepository, this._productRepository);

  @override
  Future<Either<Failure, File>> call(OpenRevisionPDFParams params) async {
    final resultProducts =
        await _productRepository.getProducts(revisionId: params.revision.id);

    return resultProducts.fold((failure) => Left(failure), (products) async {
      final _listNamesTrusted = products.map((e) => e.userName).toList();
      final _namesTrusted = _listNamesTrusted.toSet().toList();
      final revisionPDF = RevisionPDF(
        createDate: params.revision.date,
        listProducts: products,
        namesTrusted: _namesTrusted,
        revisoinDescr: params.revision.description,
        revisoinId: params.revision.id,
        revisoinName: params.revision.name,
        total: params.revision.total,
      );

      final result =
          await _filePDFRepository.generatePDF(revisionPDF: revisionPDF);
      return result.fold((failure) => Left(failure), (file) => Right(file));
    });
  }
}
