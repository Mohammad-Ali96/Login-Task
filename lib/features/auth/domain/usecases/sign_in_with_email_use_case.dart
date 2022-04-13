import 'package:login_task/core/domain/entities/failures.dart';
import 'package:login_task/core/domain/usecases/usecase.dart';
import 'package:login_task/features/auth/domain/entities/user_info.dart';
import 'package:login_task/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignInWithEmailUseCase extends UseCase<UserInfo, SignInWithEmailUseCaseParams> {
  final AuthRepository authRepository;

  SignInWithEmailUseCase(this.authRepository);

  @override
  Future<Either<Failure, UserInfo>> call(SignInWithEmailUseCaseParams params) async {
    return authRepository.signInWithEmail(params);
  }
}

class SignInWithEmailUseCaseParams {
  final String email;
  final String password;

  SignInWithEmailUseCaseParams({required this.email, required this.password});
}
