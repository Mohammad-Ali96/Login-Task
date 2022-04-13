import 'package:login_task/core/domain/entities/failures.dart';
import 'package:login_task/core/domain/usecases/usecase.dart';
import 'package:login_task/features/auth/domain/entities/user_info.dart';
import 'package:login_task/features/auth/domain/usecases/get_first_time_logged_use_case.dart';
import 'package:login_task/features/auth/domain/usecases/get_signed_in_user_use_case.dart';
import 'package:login_task/features/auth/domain/usecases/get_signed_in_with_google_use_case.dart';
import 'package:login_task/features/auth/domain/usecases/logout_use_case.dart';
import 'package:login_task/features/auth/domain/usecases/set_first_time_logged_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';

part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetSignedInUserUseCase getSignedInUser;
  final GetFirstTimeLoggedUseCase getFirstTimeLogged;
  final GetSignedInWithGoogleUseCase getSignedInWithGoogleUseCase;
  final SetFirstTimeLoggedUseCase setFirstTimeLogged;
  final LogoutUseCase logoutUseCase;

  AuthBloc(this.getSignedInUser, this.logoutUseCase, this.getFirstTimeLogged,
      this.setFirstTimeLogged, this.getSignedInWithGoogleUseCase)
      : super(AuthInitial()) {
    on<AuthSetFirstTimeLogged>((event, emit) {
      setFirstTimeLogged(SetFirstTimeLoggedUseCaseParams(
          isFirstTimeLogged: event.isFirstTimeLogged));
    });

    on<AuthCheckRequested>(
      (event, emit) async {
        emit(AuthLoading());
        final result = await getSignedInUser.call(NoParams());
        final result2 = await getFirstTimeLogged(NoParams());
        final result3 = await getSignedInWithGoogleUseCase(NoParams());
        bool isSignedWithGoogle = result3.fold((l) => false, (r) => r);
        result.fold((failure) => emit(AuthFailure(failure)), (user) {
          if (user != null) {
            emit(Authenticated(user, isSignedWithGoogle));
          } else {
            result2.fold(
                (l) => emit(AuthFailure(l)), (r) => emit(Unauthenticated(r)));
          }
        });
      },
    );

    on<AuthLogin>(
      (event, emit) {
        emit(Authenticated(event.user, event.isSignedWithGoogle));
      },
    );

    on<AuthLogout>(
      (event, emit) async {
        await logoutUseCase.call(NoParams());
        emit(Unauthenticated(false));
      },
    );
  }
}
