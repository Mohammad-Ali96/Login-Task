import 'dart:async';
import 'dart:convert';
import 'package:login_task/core/data/models/base_response/base_response.dart';
import 'package:login_task/core/domain/entities/failures.dart';
import 'package:login_task/core/domain/repositories/base_repository.dart';
import 'package:login_task/core/domain/utils/constants.dart';
import 'package:login_task/core/domain/utils/network/network_info.dart';
import 'package:login_task/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:login_task/injection.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:logger/logger.dart';

import '../../../features/auth/data/datasources/local/auth_local_datasource.dart';

class BaseRepositoryImpl implements BaseRepository {
  final AuthRemoteDataSource authRemote = getIt<AuthRemoteDataSource>();
  final AuthLocalDataSource authLocal = getIt<AuthLocalDataSource>();
  final NetworkInfo _networkInfo;
  final Logger _logger;

  BaseRepositoryImpl(this._networkInfo, this._logger);

  @override
  Future<Either<Failure, T>> request<T>(
    FutureEitherFailureOrData<T> body, {
    bool checkToken = true,
  }) async {
    try {
      if (!await _networkInfo.isConnected) {
        return left(ServerFailure(
            errorCode: ServerErrorCode.noInternetConnection, messages: []));
      }
      return await body();
    } catch (e) {
      if (e is DioError) {
        _logger.e(e.message, e, e.stackTrace);

        var message = '';
        List<String>? messages;
        var errorCode = ServerErrorCode.serverError;

        if (e.response != null) {
          errorCode = _getErrorCode(e.response!.statusCode ?? 500);
          try {
            final responseData = e.response!.data is String
                ? jsonDecode(e.response!.data)
                : e.response!.data;
            final baseResponse =
                BaseResponse.fromJson(responseData, (_) => null);
            message = baseResponse.message ?? '';
            messages = baseResponse.messages;
            if (baseResponse.code != null) {
              errorCode = _getErrorCodeFromCode(baseResponse.code!);
            }
          } catch (e) {
            return left(ServerFailure(
                errorCode: errorCode,
                message: message,
                messages: messages ?? []));
          }
        }

        return left(ServerFailure(
            errorCode: errorCode, message: message, messages: messages ?? []));
      } else if (e is Error) {
        _logger.e(e.toString(), e, e.stackTrace);
      } else {
        _logger.e(e);
      }

      return left(
          ServerFailure(errorCode: ServerErrorCode.serverError, messages: []));
    }
  }

  ServerErrorCode _getErrorCode(int statusCode) {
    switch (statusCode) {
      case 401:
        return ServerErrorCode.unauthenticated;
      case 404:
        return ServerErrorCode.notFound;
      case 403:
        return ServerErrorCode.forbidden;
      case 400:
        return ServerErrorCode.invalidData;
      case 422:
        return ServerErrorCode.wrongInput;
      default:
        return ServerErrorCode.serverError;
    }
  }

  ServerErrorCode _getErrorCodeFromCode(String code) {
    switch (int.parse(code)) {
      case 1:
        return ServerErrorCode.customError;
      default:
        return ServerErrorCode.serverError;
    }
  }
}
