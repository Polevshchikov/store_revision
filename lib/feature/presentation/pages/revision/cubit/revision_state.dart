part of 'revision_cubit.dart';

class RevisionState extends Equatable {
  final List<ProductEntity> products;
  final Status status;
  final Failure failure;

  const RevisionState._({
    this.products = const [],
    this.status = Status.unknow,
    this.failure = const UnknownFailure(),
  });

  factory RevisionState.initial() => const RevisionState._();

  factory RevisionState.loading() =>
      const RevisionState._(status: Status.waiting);

  factory RevisionState.success(List<ProductEntity> products) =>
      RevisionState._(
        status: Status.success,
        products: products,
      );

  factory RevisionState.error(Failure failure) => RevisionState._(
        status: Status.error,
        failure: failure,
      );

  @override
  List<Object> get props => [
        products,
        status,
        failure,
      ];
}
