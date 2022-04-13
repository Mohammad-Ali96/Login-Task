import 'package:dartz/dartz.dart';
import 'package:login_task/core/domain/entities/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
