part of 'sign_in_with_email_bloc.dart';


abstract class SignInWithEmailState {}

class Initial extends SignInWithEmailState {}

class SignInWithEmailSuccessful extends SignInWithEmailState {
  final UserInfo user;

  SignInWithEmailSuccessful({
    required this.user,
  });
}

class SignInWithEmailLoading extends SignInWithEmailState {}

class SignInWithEmailFailure extends SignInWithEmailState {
  final Failure failure;

  SignInWithEmailFailure(this.failure);
}
