import 'dart:async';

import 'package:dio/dio.dart';
import 'package:login_task/features/auth/domain/repositories/auth_repository.dart';
import 'package:login_task/injection.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';


@module
abstract class InjectableModule {
  @lazySingleton
  InternetConnectionChecker get connectionChecker =>
      InternetConnectionChecker();

  @preResolve
  @lazySingleton
  Future<SharedPreferences> get sharedPref => SharedPreferences.getInstance();

  @lazySingleton
  GoogleSignIn get googleSignIn => GoogleSignIn();


  @lazySingleton
  Dio get dioInstance {
    final dio = Dio(
      BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          validateStatus: (statusCode) {
            if (statusCode != null) {
              if (200 <= statusCode && statusCode < 300) {
                return true;
              } else {
                return false;
              }
            } else {
              return false;
            }
          }),
    );

    dio.interceptors.add(
      LogInterceptor(
          responseBody: true,
          requestBody: true,
          logPrint: (obj) {
            debugPrint(obj.toString());
          }),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) async {
          Map<String, String> headers;

          final failureOrUser = await getIt<AuthRepository>().getSignedInUser();
          final user = failureOrUser.getOrElse(() => null);
          if (user != null) {
            headers = {'Authorization': 'Bearer User Token'};
            request.headers.addAll(headers);
          }

          request.sendTimeout = 60000;
          request.connectTimeout = 60000;
          request.receiveTimeout = 60000;

          return handler.next(request);
        },
      ),
    );

    return dio;
  }


  @lazySingleton
  DioAdapter get dioAdapter => DioAdapter(dio: dioInstance);


  @lazySingleton
  Logger get logger => Logger();


}
