part of 'product_add_cubit.dart';

class ProductAddState extends Equatable {
  const ProductAddState._({
    this.scannQr = '',
    this.name = const Name.pure(),
    this.cost = const Num.pure(),
    this.count = const Num.pure(),
    this.status = FormzStatus.pure,
    this.failure = const UnknownFailure(),
  });

  final String scannQr;
  final Name name;
  final Num cost;
  final Num count;
  final FormzStatus status;
  final Failure failure;

  ProductAddState copyWith({
    String? scannQr,
    Name? name,
    Num? cost,
    Num? count,
    FormzStatus? status,
    Failure? failure,
  }) {
    return ProductAddState._(
      scannQr: scannQr ?? '',
      name: name ?? this.name,
      cost: cost ?? this.cost,
      count: count ?? this.count,
      status: status ?? this.status,
      failure: failure ?? const UnknownFailure(),
    );
  }

  factory ProductAddState.initial() => const ProductAddState._(
        status: FormzStatus.pure,
        failure: UnknownFailure(),
      );

  factory ProductAddState.success() => const ProductAddState._(
        status: FormzStatus.submissionSuccess,
      );

  factory ProductAddState.error(Failure failure) => ProductAddState._(
        failure: failure,
        status: FormzStatus.submissionFailure,
      );

  @override
  List<Object> get props => [
        scannQr,
        name,
        cost,
        count,
        status,
        failure,
      ];
}
