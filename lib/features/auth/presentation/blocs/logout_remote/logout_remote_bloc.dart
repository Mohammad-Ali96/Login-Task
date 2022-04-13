import 'package:bloc/bloc.dart';
import 'package:login_task/core/domain/entities/failures.dart';
import 'package:login_task/core/domain/usecases/usecase.dart';
import 'package:login_task/features/auth/domain/usecases/logout_remote_use_case.dart';
import 'package:injectable/injectable.dart';

part 'logout_remote_event.dart';

part 'logout_remote_state.dart';

@injectable
class LogoutRemoteBloc extends Bloc<LogoutRemoteEvent, LogoutRemoteState> {
  final LogoutRemoteUseCase logoutRemoteUseCase;

  LogoutRemoteBloc({
    required this.logoutRemoteUseCase,
  }) : super(Initial()) {
    on<LogoutRemoteOnSubmit>(
      (event, emit) async {
        emit(LogoutRemoteLoading());
        final result = await logoutRemoteUseCase(NoParams());
        result.fold((l) {
          emit(LogoutRemoteFailure(l));
        }, (success) {
          emit(LogoutRemoteSuccessful(success: success));
        });
      },
    );
  }
}
