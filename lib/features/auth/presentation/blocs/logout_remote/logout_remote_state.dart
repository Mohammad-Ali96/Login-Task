part of 'logout_remote_bloc.dart';


abstract class LogoutRemoteState {}

class Initial extends LogoutRemoteState {}

class LogoutRemoteSuccessful extends LogoutRemoteState {
  final bool success;

  LogoutRemoteSuccessful({required this.success});

}

class LogoutRemoteLoading extends LogoutRemoteState {}

class LogoutRemoteFailure extends LogoutRemoteState {
  final Failure failure;

  LogoutRemoteFailure(this.failure);
}
