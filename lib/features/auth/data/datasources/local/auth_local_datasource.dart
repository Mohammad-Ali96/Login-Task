import 'dart:async';
import 'dart:convert';

import 'package:login_task/core/data/utils/constants.dart';
import 'package:login_task/features/auth/data/models/user_info/user_info_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> signInUser(UserInfoModel user);

  UserInfoModel? getSignedInUser();

  void logout();


  void setFirstTimeLogged(bool firstTimeLogged);
  void setSignedInWithGoogle(bool signedInWithGoogle);

  bool getIsFirstTimeLogged();
  bool getSignedInWithGoogle();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> signInUser(UserInfoModel user) async {
    await sharedPreferences.setString(
      SharedPreferencesKeys.user,
      json.encode(user.toJson()),
    );
  }

  @override
  UserInfoModel? getSignedInUser() {
    if (!sharedPreferences.containsKey(SharedPreferencesKeys.user)) return null;

    return UserInfoModel.fromJson(
      json.decode(sharedPreferences.getString(SharedPreferencesKeys.user)!)
          as Map<String, dynamic>,
    );
  }

  @override
  void logout() {
    sharedPreferences.remove(SharedPreferencesKeys.user);
    sharedPreferences.remove(SharedPreferencesKeys.isSignedInWithGoogle);
  }

  @override
  bool getIsFirstTimeLogged() {
    return sharedPreferences.getBool(SharedPreferencesKeys.isFirstTimeLogged) !=
        false;
  }

  @override
  bool getSignedInWithGoogle() {
    return sharedPreferences.getBool(SharedPreferencesKeys.isSignedInWithGoogle) !=
        false;
  }


  @override
  void setFirstTimeLogged(bool firstTimeLogged) {
    sharedPreferences.setBool(
        SharedPreferencesKeys.isFirstTimeLogged, firstTimeLogged);
  }
  @override
  void setSignedInWithGoogle(bool signedInWithGoogle) {
    sharedPreferences.setBool(
        SharedPreferencesKeys.isSignedInWithGoogle, signedInWithGoogle);
  }


}
