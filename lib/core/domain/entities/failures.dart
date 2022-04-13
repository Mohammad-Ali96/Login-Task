

import 'package:login_task/core/domain/utils/constants.dart';

abstract class Failure {}

class ServerFailure implements Failure {
  final ServerErrorCode errorCode;
  final String message;
  final List<String>? messages;

  ServerFailure({required this.errorCode, this.message = '', this.messages});
}

class CacheFailure implements Failure {}

class LogicFailure implements Failure {
  final String message;

  LogicFailure(this.message);
}

class AppAccessDeniedFailure implements Failure {}
