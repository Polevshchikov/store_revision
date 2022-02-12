import 'package:dartz/dartz.dart';
import 'package:store_revision/core/error/failure.dart';

///[Type] предназначен для типа возврата без ошибок
///[Params] вызовет некоторые незначительные изменения кода уже в существующих usecases
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
