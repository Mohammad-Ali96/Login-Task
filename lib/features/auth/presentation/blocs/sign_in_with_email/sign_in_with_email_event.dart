part of 'sign_in_with_email_bloc.dart';

abstract class SignInWithEmailEvent {}

class SignInOnSubmit extends SignInWithEmailEvent {
  final SignInWithEmailUseCaseParams params;

  SignInOnSubmit(this.params);
}
