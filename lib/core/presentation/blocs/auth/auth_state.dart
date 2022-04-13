part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  final UserInfo user;
  final bool isSignedInWithGoogle;

  Authenticated(this.user, this.isSignedInWithGoogle);
}

class Unauthenticated extends AuthState {
  final bool isFirstTimeLogged;

  Unauthenticated(this.isFirstTimeLogged);
}

class AuthFailure extends AuthState {
  final Failure failure;

  AuthFailure(this.failure);
}

class AuthLoading extends AuthState {}
