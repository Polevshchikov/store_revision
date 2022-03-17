part of 'product_edit_cubit.dart';

class ProductEditState extends Equatable {
  const ProductEditState._({
    this.status = Status.unknow,
    this.failure = const UnknownFailure(),
  });

  final Status status;
  final Failure failure;

  factory ProductEditState.initial() => const ProductEditState._();

  factory ProductEditState.loading() =>
      const ProductEditState._(status: Status.waiting);

  factory ProductEditState.success() =>
      const ProductEditState._(status: Status.success);

  factory ProductEditState.error(Failure failure) => ProductEditState._(
        failure: failure,
        status: Status.error,
      );

  @override
  List<Object> get props => [status, failure];
}
