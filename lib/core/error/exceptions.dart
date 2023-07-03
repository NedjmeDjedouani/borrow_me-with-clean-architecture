import 'package:equatable/equatable.dart';

import '../api/statuscode.dart';

abstract class Failure extends Equatable implements Exception {
  Failure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class CacheException extends Failure {
  CacheException(super.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message, this.statusCode);
  final int statusCode;

  @override
  List<Object?> get props => [this.message, this.statusCode];
}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}

class AppErrors {
  static final badRequestError =
      ServerFailure('bad request', StatusCode.badRequest);
  static final notFoundError = ServerFailure("not found", StatusCode.notFound);
  static final conflictError =
      ServerFailure("conflict occur", StatusCode.conflict);
  static final unauthorizedError =
      ServerFailure("unauthorized", StatusCode.unauthorized);
  static final invalidParamsError =
      ServerFailure("invalid params", StatusCode.invalidParams);
  static final forbiddenError =
      ServerFailure("forbidden", StatusCode.forbidden);
  static final internalServerError =
      ServerFailure("Internal Server Error", StatusCode.internalServerError);
}
