part of 'revision_pdf_cubit.dart';

class RevisionPdfState extends Equatable {
  final File? filePDF;
  final Status status;
  final Failure failure;

  const RevisionPdfState._({
    this.filePDF,
    this.status = Status.unknow,
    this.failure = const UnknownFailure(),
  });

  factory RevisionPdfState.initial() => const RevisionPdfState._();

  factory RevisionPdfState.loading() =>
      const RevisionPdfState._(status: Status.waiting);

  factory RevisionPdfState.success(File? filePDF) => RevisionPdfState._(
        status: Status.success,
        filePDF: filePDF,
      );

  factory RevisionPdfState.error(Failure failure) => RevisionPdfState._(
        status: Status.error,
        failure: failure,
      );

  @override
  List<Object> get props => [
        status,
        failure,
      ];
}
