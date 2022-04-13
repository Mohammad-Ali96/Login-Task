import 'package:dartz/dartz.dart';
import 'package:login_task/core/domain/entities/failures.dart';

typedef FutureEitherFailureOrData<T> = Future<Either<Failure, T>> Function();

abstract class BaseRepository {
  Future<Either<Failure, T>> request<T>(
    FutureEitherFailureOrData<T> body, {
    bool checkToken = true,
  });
}
