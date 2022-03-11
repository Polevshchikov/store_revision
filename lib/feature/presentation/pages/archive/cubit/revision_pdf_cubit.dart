import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_revision/core/error/failure.dart';
import 'package:store_revision/feature/domain/entities/revision_entity.dart';
import 'package:store_revision/feature/domain/usecases/open_revision_pdf_usecase.dart';
import 'package:store_revision/feature/domain/usecases/params/open_revision_pdf_params.dart';
import 'package:store_revision/feature/presentation/utils/status.dart';
import 'package:injectable/injectable.dart';
part 'revision_pdf_state.dart';

@injectable
class RevisionPdfCubit extends Cubit<RevisionPdfState> {
  final OpenRevisionPDFUseCase _openRevisionPDFUseCase;
  RevisionPdfCubit(this._openRevisionPDFUseCase)
      : super(RevisionPdfState.initial());

  Future<void> openRevisionPDF(RevisionEntity revision) async {
    emit(RevisionPdfState.loading());
    final result = await _openRevisionPDFUseCase
        .call(OpenRevisionPDFParams(revision: revision));
    emit(result.fold((failure) => RevisionPdfState.error(failure),
        (file) => RevisionPdfState.success(file)));
  }
}
  //  final url = file.path;
  //   await OpenFile .open(url);