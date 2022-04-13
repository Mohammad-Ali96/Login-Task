import 'dart:async';


import 'package:dartz/dartz.dart';
import 'package:login_task/core/domain/entities/failures.dart';
import 'package:login_task/core/domain/usecases/usecase.dart';
import 'package:login_task/features/auth/domain/entities/user_info.dart';
import 'package:login_task/features/auth/domain/usecases/sign_in_with_email_use_case.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserInfo?>> getSignedInUser();

  Future<Either<Failure, UserInfo>> signInWithEmail(SignInWithEmailUseCaseParams params);
  Future<Either<Failure, UserInfo>> signInWithGoogle(NoParams params);

  Future<Either<Failure, Unit>> logout();
  Future<Either<Failure, bool>> logoutRemote();



  Future<Either<Failure, bool>> getIsFirstTimeLogged();
  Future<Either<Failure, void>> setFirstTimeLogged(bool firstTimeLogged);


  Future<Either<Failure, bool>> getSignedInWithGoogle();
  Future<Either<Failure, void>> setSignedInWithGoogle(bool signedInWithGoogle);







}
