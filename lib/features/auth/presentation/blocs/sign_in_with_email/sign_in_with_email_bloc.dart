import 'package:bloc/bloc.dart';
import 'package:login_task/core/domain/entities/failures.dart';
import 'package:login_task/features/auth/domain/entities/user_info.dart';
import 'package:login_task/features/auth/domain/usecases/sign_in_with_email_use_case.dart';
import 'package:injectable/injectable.dart';

part 'sign_in_with_email_event.dart';

part 'sign_in_with_email_state.dart';

@injectable
class SignInWithEmailBloc extends Bloc<SignInWithEmailEvent, SignInWithEmailState> {
  final SignInWithEmailUseCase login;

  SignInWithEmailBloc({
    required this.login,
  }) : super(Initial()) {
    on<SignInOnSubmit>(
      (event, emit) async {
        emit(SignInWithEmailLoading());
        final result = await login(event.params);
        result.fold(
          (l) {
            emit(SignInWithEmailFailure(l));
          },
          (user) {
            emit(SignInWithEmailSuccessful(user: user));
          },
        );
      },
    );
  }
}
