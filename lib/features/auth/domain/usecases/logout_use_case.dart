import 'package:login_task/core/domain/entities/failures.dart';
import 'package:login_task/core/domain/usecases/usecase.dart';
import 'package:login_task/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LogoutUseCase extends UseCase<Unit, NoParams> {
  final AuthRepository repository;

  LogoutUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return repository.logout();
  }
}
