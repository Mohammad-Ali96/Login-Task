import 'package:login_task/core/domain/entities/failures.dart';
import 'package:login_task/core/domain/usecases/usecase.dart';
import 'package:login_task/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SetSignedInWithGoogleUseCase
    extends UseCase<void, SetFirstTimeLoggedUseCaseParams> {
  final AuthRepository authRepository;

  SetSignedInWithGoogleUseCase(this.authRepository);

  @override
  Future<Either<Failure, void>> call(params) async {
    return authRepository.setSignedInWithGoogle(params.isSignedInWithGoogle);
  }
}

class SetFirstTimeLoggedUseCaseParams {
  final bool isSignedInWithGoogle;

  SetFirstTimeLoggedUseCaseParams({required this.isSignedInWithGoogle});
}
