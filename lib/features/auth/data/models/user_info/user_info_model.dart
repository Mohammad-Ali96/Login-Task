import 'package:login_task/features/auth/domain/entities/user_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_info_model.g.dart';

@JsonSerializable(createToJson: true)
class UserInfoModel {
  final String id;
  final String name;
  final String email;
  UserInfoModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);

  UserInfoModel copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? countryCode,
  }) {
    return UserInfoModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}

extension MapUserInfoModelToDomain on UserInfoModel {
  UserInfo toDomain() => UserInfo(
    id: id,
    name: name,
    email: email,
  );
}
