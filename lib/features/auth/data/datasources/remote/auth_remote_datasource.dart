import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:login_task/core/data/models/base_response/base_response.dart';
import 'package:login_task/core/data/utils/configuration.dart';
import 'package:login_task/features/auth/data/models/user_info/user_info_model.dart';
import 'package:injectable/injectable.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

abstract class AuthRemoteDataSource {
  Future<BaseResponse<UserInfoModel>> signInWithEmail(
      {required String email, required String password});

  Future<BaseResponse<bool>> logoutRemote();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  final Configuration configuration;

  AuthRemoteDataSourceImpl(this.dio, this.configuration);

  @override
  Future<BaseResponse<UserInfoModel>> signInWithEmail(
      {required String email, required String password}) async {
    // Simulate network connection
    await Future.delayed(const Duration(seconds: 2));

    final DioAdapter dioAdapter = DioAdapter(dio: dio);
    final String url = '${configuration.getBaseUrl}/auth/login';
    final Map<String, dynamic> data = {
      'email': email,
      'password': password,
    };
    final UserInfoModel user = UserInfoModel(
      email: email,
      name: '',
      id: '1',
    );
    // Mocking sign in
    dioAdapter.onPost(
      url,
      (server) => server.reply(
        200,
        json.encode(user.toJson()),
      ),
      data: data,
    );
    final userResponse = await dio.post(
      url,
      data: data,
    );
    return BaseResponse(
      message: 'SUCCESS',
      data: UserInfoModel.fromJson(json.decode(userResponse.data)),
    );
  }

  @override
  Future<BaseResponse<bool>> logoutRemote() async {
    // Simulate network connection
    await Future.delayed(const Duration(seconds: 3));

    final DioAdapter dioAdapter = DioAdapter(dio: dio);
    final String url = '${configuration.getBaseUrl}/auth/logout';

    // Mocking logout
    dioAdapter.onPost(
      url,
          (server) => server.reply(
        200,
        json.encode({'success' : true}),
      ),
    );
    final response = await dio.post(
      url,
    );
    return BaseResponse(
      message: 'SUCCESS',
      data: json.decode(response.data)['success'],
    );
  }
}
