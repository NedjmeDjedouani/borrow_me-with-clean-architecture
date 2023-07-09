import 'package:equatable/equatable.dart';

import '../api/statuscode.dart';

abstract class Failure extends Equatable implements Exception {
  const Failure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class CacheException extends Failure {
  const CacheException(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, this.statusCode);
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class AppErrors {
  static const badRequestError =
      ServerFailure('bad request', StatusCode.badRequest);
  static const notFoundError = ServerFailure("not found", StatusCode.notFound);
  static const conflictError =
      ServerFailure("conflict occur", StatusCode.conflict);
  static const unauthorizedError =
      ServerFailure("unauthorized", StatusCode.unauthorized);
  static const invalidParamsError =
      ServerFailure("invalid params", StatusCode.invalidParams);
  static const forbiddenError =
      ServerFailure("forbidden", StatusCode.forbidden);
  static const internalServerError =
      ServerFailure("Internal Server Error", StatusCode.internalServerError);
}
