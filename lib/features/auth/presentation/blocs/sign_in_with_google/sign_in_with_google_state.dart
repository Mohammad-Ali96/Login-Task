part of 'sign_in_with_google_bloc.dart';


abstract class SignInWithGoogleState {}

class Initial extends SignInWithGoogleState {}

class SignInWithGoogleSuccessful extends SignInWithGoogleState {
  final UserInfo user;

  SignInWithGoogleSuccessful({
    required this.user,
  });
}

class SignInWithGoogleLoading extends SignInWithGoogleState {}

class SignInWithGoogleFailure extends SignInWithGoogleState {
  final Failure failure;

  SignInWithGoogleFailure(this.failure);
}
