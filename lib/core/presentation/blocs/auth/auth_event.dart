part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthCheckRequested extends AuthEvent {}

class AuthLogin extends AuthEvent {
  final UserInfo user;
  final bool isSignedWithGoogle;

  AuthLogin(this.user, this.isSignedWithGoogle);
}

class AuthLogout extends AuthEvent {}

class AuthSetFirstTimeLogged extends AuthEvent {
  final bool isFirstTimeLogged;
  AuthSetFirstTimeLogged({required this.isFirstTimeLogged});
}
