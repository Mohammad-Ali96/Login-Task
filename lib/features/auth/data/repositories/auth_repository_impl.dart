import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:login_task/core/domain/usecases/usecase.dart';
import 'package:login_task/core/domain/utils/constants.dart';
import 'package:login_task/features/auth/domain/entities/user_info.dart';
import 'package:login_task/features/auth/data/models/user_info/user_info_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_task/core/data/repositories/base_repository_impl.dart';
import 'package:login_task/core/data/utils/configuration.dart';
import 'package:login_task/core/domain/entities/failures.dart';
import 'package:login_task/core/domain/utils/network/network_info.dart';
import 'package:login_task/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:login_task/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:login_task/features/auth/domain/repositories/auth_repository.dart';
import 'package:login_task/features/auth/domain/usecases/sign_in_with_email_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends BaseRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource local;
  final AuthRemoteDataSource remote;
  final GoogleSignIn googleSignIn;
  final NetworkInfo networkInfo;
  final Logger logger;
  final Configuration configuration;

  AuthRepositoryImpl(this.local, this.remote, this.googleSignIn,
      this.networkInfo, this.logger, this.configuration)
      : super(networkInfo, logger);

  @override
  Future<Either<Failure, UserInfo?>> getSignedInUser() async {
    return right(local.getSignedInUser()?.toDomain());
  }

  @override
  Future<Either<Failure, UserInfo>> signInWithEmail(
      SignInWithEmailUseCaseParams params) async {
    // request method handles all status code like 401, 404 ... etc
    return request(
      () async {
        var userResponse = await remote.signInWithEmail(
          email: params.email,
          password: params.password,
        );
        local.signInUser(userResponse.data!);
        return right(userResponse.data!.toDomain());
      },
      checkToken: false,
    );
  }

  @override
  Future<Either<Failure, UserInfo>> signInWithGoogle(NoParams params) async {
    return request(
      () async {
        var userResponse = await googleSignIn.signIn();
        if (userResponse != null) {
          UserInfo user = UserInfo(
            id: userResponse.id,
            email: userResponse.email,
            name: userResponse.displayName ?? '',
          );
          // Storing user info in sharedPreferences
          local.signInUser(
            UserInfoModel(
              id: user.id,
              email: user.email,
              name: user.name,
            ),
          );
          local.setSignedInWithGoogle(true);
          return right(user);
        } else {
          return left(
            ServerFailure(
              errorCode: ServerErrorCode.unauthenticated,
            ),
          );
        }
      },
      checkToken: false,
    );
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    local.logout();
    return right(unit);
  }

  @override
  Future<Either<Failure, bool>> logoutRemote() async {
    return request(() async {
      bool isSignedWithGoogle = local.getSignedInWithGoogle();
      if (isSignedWithGoogle) {
        await googleSignIn.signOut();
      } else {
        await remote.logoutRemote();
      }
      return right(true);
    });
  }

  @override
  Future<Either<Failure, bool>> getIsFirstTimeLogged() async {
    return right(local.getIsFirstTimeLogged());
  }

  @override
  Future<Either<Failure, void>> setFirstTimeLogged(bool firstTimeLogged) async {
    return right(local.setFirstTimeLogged(firstTimeLogged));
  }

  @override
  Future<Either<Failure, void>> setSignedInWithGoogle(
      bool signedInWithGoogle) async {
    return right(local.setSignedInWithGoogle(signedInWithGoogle));
  }

  @override
  Future<Either<Failure, bool>> getSignedInWithGoogle() async {
    return right(local.getSignedInWithGoogle());
  }
}
