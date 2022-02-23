part of 'product_add_cubit.dart';

class ProductAddState extends Equatable {
  const ProductAddState({
    this.name = const Name.pure(),
    this.cost = const Num.pure(),
    this.count = const Num.pure(),
    this.status = FormzStatus.pure,
    this.failure = const UnknownFailure(),
  });

  final Name name;
  final Num cost;
  final Num count;
  final FormzStatus status;
  final Failure failure;

  ProductAddState copyWith({
    Name? name,
    Num? cost,
    Num? count,
    FormzStatus? status,
    Failure? failure,
  }) {
    return ProductAddState(
      name: name ?? this.name,
      cost: cost ?? this.cost,
      count: count ?? this.count,
      status: status ?? this.status,
      failure: failure ?? const UnknownFailure(),
    );
  }

  @override
  List<Object> get props => [
        name,
        cost,
        count,
        status,
        failure,
      ];
}
