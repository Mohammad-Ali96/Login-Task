// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i6;
import 'package:http_mock_adapter/http_mock_adapter.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i7;
import 'package:logger/logger.dart' as _i8;
import 'package:shared_preferences/shared_preferences.dart' as _i12;

import 'core/data/utils/configuration.dart' as _i3;
import 'core/data/utils/network/network_info.dart' as _i11;
import 'core/domain/utils/network/network_info.dart' as _i10;
import 'core/presentation/blocs/auth/auth_bloc.dart' as _i27;
import 'core/presentation/utils/message_utils.dart' as _i9;
import 'core/presentation/utils/validation_util.dart' as _i13;
import 'features/auth/data/datasources/local/auth_local_datasource.dart'
    as _i14;
import 'features/auth/data/datasources/remote/auth_remote_datasource.dart'
    as _i15;
import 'features/auth/data/repositories/auth_repository_impl.dart' as _i17;
import 'features/auth/domain/repositories/auth_repository.dart' as _i16;
import 'features/auth/domain/usecases/get_first_time_logged_use_case.dart'
    as _i18;
import 'features/auth/domain/usecases/get_signed_in_user_use_case.dart' as _i19;
import 'features/auth/domain/usecases/get_signed_in_with_google_use_case.dart'
    as _i20;
import 'features/auth/domain/usecases/logout_remote_use_case.dart' as _i21;
import 'features/auth/domain/usecases/logout_use_case.dart' as _i22;
import 'features/auth/domain/usecases/set_first_time_logged_use_case.dart'
    as _i23;
import 'features/auth/domain/usecases/set_signed_in_with_google_use_case.dart'
    as _i24;
import 'features/auth/domain/usecases/sign_in_with_email_use_case.dart' as _i25;
import 'features/auth/domain/usecases/sign_in_with_google_use_case.dart'
    as _i26;
import 'features/auth/presentation/blocs/logout_remote/logout_remote_bloc.dart'
    as _i28;
import 'features/auth/presentation/blocs/sign_in_with_email/sign_in_with_email_bloc.dart'
    as _i29;
import 'features/auth/presentation/blocs/sign_in_with_google/sign_in_with_google_bloc.dart'
    as _i30;
import 'injectable_module.dart' as _i31;

const String _dev = 'dev';
const String _staging = 'staging';
const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final injectableModule = _$InjectableModule();
  gh.lazySingleton<_i3.Configuration>(() => _i3.DevConfiguration(),
      registerFor: {_dev});
  gh.lazySingleton<_i3.Configuration>(() => _i3.StagingConfiguration(),
      registerFor: {_staging});
  gh.lazySingleton<_i3.Configuration>(() => _i3.ProductionConfiguration(),
      registerFor: {_prod});
  gh.lazySingleton<_i4.Dio>(() => injectableModule.dioInstance);
  gh.lazySingleton<_i5.DioAdapter>(() => injectableModule.dioAdapter);
  gh.lazySingleton<_i6.GoogleSignIn>(() => injectableModule.googleSignIn);
  gh.lazySingleton<_i7.InternetConnectionChecker>(
      () => injectableModule.connectionChecker);
  gh.lazySingleton<_i8.Logger>(() => injectableModule.logger);
  gh.lazySingleton<_i9.MessageUtils>(() => _i9.MessageUtils());
  gh.lazySingleton<_i10.NetworkInfo>(
      () => _i11.NetworkInfoImpl(get<_i7.InternetConnectionChecker>()));
  await gh.lazySingletonAsync<_i12.SharedPreferences>(
      () => injectableModule.sharedPref,
      preResolve: true);
  gh.lazySingleton<_i13.Validation>(() => _i13.Validation());
  gh.lazySingleton<_i14.AuthLocalDataSource>(
      () => _i14.AuthLocalDataSourceImpl(get<_i12.SharedPreferences>()));
  gh.lazySingleton<_i15.AuthRemoteDataSource>(() =>
      _i15.AuthRemoteDataSourceImpl(get<_i4.Dio>(), get<_i3.Configuration>()));
  gh.lazySingleton<_i16.AuthRepository>(() => _i17.AuthRepositoryImpl(
      get<_i14.AuthLocalDataSource>(),
      get<_i15.AuthRemoteDataSource>(),
      get<_i6.GoogleSignIn>(),
      get<_i10.NetworkInfo>(),
      get<_i8.Logger>(),
      get<_i3.Configuration>()));
  gh.lazySingleton<_i18.GetFirstTimeLoggedUseCase>(
      () => _i18.GetFirstTimeLoggedUseCase(get<_i16.AuthRepository>()));
  gh.lazySingleton<_i19.GetSignedInUserUseCase>(
      () => _i19.GetSignedInUserUseCase(get<_i16.AuthRepository>()));
  gh.lazySingleton<_i20.GetSignedInWithGoogleUseCase>(
      () => _i20.GetSignedInWithGoogleUseCase(get<_i16.AuthRepository>()));
  gh.lazySingleton<_i21.LogoutRemoteUseCase>(
      () => _i21.LogoutRemoteUseCase(repository: get<_i16.AuthRepository>()));
  gh.lazySingleton<_i22.LogoutUseCase>(
      () => _i22.LogoutUseCase(repository: get<_i16.AuthRepository>()));
  gh.lazySingleton<_i23.SetFirstTimeLoggedUseCase>(
      () => _i23.SetFirstTimeLoggedUseCase(get<_i16.AuthRepository>()));
  gh.lazySingleton<_i24.SetSignedInWithGoogleUseCase>(
      () => _i24.SetSignedInWithGoogleUseCase(get<_i16.AuthRepository>()));
  gh.lazySingleton<_i25.SignInWithEmailUseCase>(
      () => _i25.SignInWithEmailUseCase(get<_i16.AuthRepository>()));
  gh.lazySingleton<_i26.SignInWithGoogleUseCase>(
      () => _i26.SignInWithGoogleUseCase(get<_i16.AuthRepository>()));
  gh.factory<_i27.AuthBloc>(() => _i27.AuthBloc(
      get<_i19.GetSignedInUserUseCase>(),
      get<_i22.LogoutUseCase>(),
      get<_i18.GetFirstTimeLoggedUseCase>(),
      get<_i23.SetFirstTimeLoggedUseCase>(),
      get<_i20.GetSignedInWithGoogleUseCase>()));
  gh.factory<_i28.LogoutRemoteBloc>(() => _i28.LogoutRemoteBloc(
      logoutRemoteUseCase: get<_i21.LogoutRemoteUseCase>()));
  gh.factory<_i29.SignInWithEmailBloc>(() =>
      _i29.SignInWithEmailBloc(login: get<_i25.SignInWithEmailUseCase>()));
  gh.factory<_i30.SignInWithGoogleBloc>(() => _i30.SignInWithGoogleBloc(
      signInWithGoogleUseCase: get<_i26.SignInWithGoogleUseCase>()));
  return get;
}

class _$InjectableModule extends _i31.InjectableModule {}
