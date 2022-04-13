import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  @JsonKey(name: 'msg', defaultValue: '')
  final String? message;
  final int? totalRecords;
  final T? data;
  final String? code;
  final List<String>? messages;
  @JsonKey(name: 'status', defaultValue: false)
  final bool? status;






  BaseResponse({
    required this.message,
    this.totalRecords,
    this.messages,
    this.data,
    this.code,
    this.status,
  });

  factory BaseResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseResponseFromJson(json, fromJsonT);
}
