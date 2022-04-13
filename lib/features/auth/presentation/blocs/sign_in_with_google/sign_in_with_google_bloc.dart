import 'package:bloc/bloc.dart';
import 'package:login_task/core/domain/entities/failures.dart';
import 'package:login_task/core/domain/usecases/usecase.dart';
import 'package:login_task/features/auth/domain/entities/user_info.dart';
import 'package:login_task/features/auth/domain/usecases/sign_in_with_google_use_case.dart';
import 'package:injectable/injectable.dart';

part 'sign_in_with_google_event.dart';

part 'sign_in_with_google_state.dart';

@injectable
class SignInWithGoogleBloc
    extends Bloc<SignInWithGoogleEvent, SignInWithGoogleState> {
  final SignInWithGoogleUseCase signInWithGoogleUseCase;

  SignInWithGoogleBloc({
    required this.signInWithGoogleUseCase,
  }) : super(Initial()) {
    on<SignInWithGoogleOnSubmit>(
      (event, emit) async {
        emit(SignInWithGoogleLoading());
        final result = await signInWithGoogleUseCase(NoParams());
        result.fold(
          (l) {
            emit(SignInWithGoogleFailure(l));
          },
          (user) {
            emit(SignInWithGoogleSuccessful(user: user));
          },
        );
      },
    );
  }
}
