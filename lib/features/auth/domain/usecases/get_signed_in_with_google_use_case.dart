import 'package:dartz/dartz.dart';
import 'package:login_task/core/domain/entities/failures.dart';
import 'package:login_task/core/domain/usecases/usecase.dart';
import 'package:login_task/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetSignedInWithGoogleUseCase extends UseCase<bool?, NoParams> {
  final AuthRepository authRepository;

  GetSignedInWithGoogleUseCase(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return authRepository.getSignedInWithGoogle();
  }
}
