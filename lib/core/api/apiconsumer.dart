import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:test_app/core/api/statuscode.dart';
import 'package:test_app/core/error/exceptions.dart';
import 'package:path/path.dart' as p;
import 'package:logger/logger.dart';

import '../utils/constants.dart';

abstract class ApiConsumer {
  Future<dynamic> get(
      {required String endpoint,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers});
  Future<dynamic> post(
      {required String endpoint,
      required Map<String, dynamic> data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers});
  Future<void> patch(
      {required String endpoint,
      required Map<String, dynamic> data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers});
  Future<void> delete(
      {required String endpoint,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers});
}

Map<String, dynamic> buildHeaders(Map<String, dynamic>? headers) {
  if (headers == null) {
    return {contentType: applicationJSON};
  } else if (headers.containsKey(contentType)) {
    return headers;
  } else {
    return {...headers, contentType: applicationJSON};
  }
}

String buildUrlPath(String endpoint) {
  return p.join(baseurl, endpoint);
}

ServerFailure getErrorfromStatusCode(int statusCode) {
  switch (statusCode) {
    case StatusCode.badRequest:
      return AppErrors.badRequestError;
    case StatusCode.unauthorized:
      return AppErrors.unauthorizedError;
    case StatusCode.notFound:
      return AppErrors.notFoundError;
    case StatusCode.conflict:
      return AppErrors.conflictError;
    case StatusCode.internalServerError:
      return AppErrors.internalServerError;
    case StatusCode.forbidden:
      return AppErrors.forbiddenError;
    default:
      return AppErrors.internalServerError;
  }
}

class DioConsumer implements ApiConsumer {
  final dioClient = Dio();
  var logger = Logger();
  @override
  Future<dynamic> get(
      {required String endpoint,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    final requestHeaders = buildHeaders(headers);
    final response = await dioClient.get(buildUrlPath(endpoint),
        queryParameters: queryParameters,
        options: Options(headers: requestHeaders));
    logger.i(response);
    if (response.statusCode == StatusCode.ok) {
      final data = response.data["data"];
      return data;
    } else {
      throw getErrorfromStatusCode(response.statusCode!);
    }
  }

  @override
  Future<void> patch(
      {required String endpoint,
      required Map<String, dynamic> data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    final requestHeaders = buildHeaders(headers);
    try {
      final response = await dioClient.patch(buildUrlPath(endpoint),
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: requestHeaders));
      logger.i(response.statusCode);
      if (response.statusCode != StatusCode.ok) {
        throw getErrorfromStatusCode(response.statusCode!);
      }
    } catch (e) {
      if (e is ServerFailure) {
        rethrow;
      } else {
        logger.e(e);
        throw const ServerFailure("something went wrong", 500);
      }
    }
  }

  @override
  Future<dynamic> post(
      {required String endpoint,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      bool formDataIsEnabled = false,
      required Map<String, dynamic> data}) async {
    final requestHeaders = buildHeaders(headers);
    try {
      final response = await dioClient.post(buildUrlPath(endpoint),
          data: formDataIsEnabled ? FormData.fromMap(data) : data,
          queryParameters: queryParameters,
          options: Options(headers: requestHeaders));
      logger.i(response);
      if (response.statusCode == StatusCode.ok) {
        final data = jsonDecode(response.data['data']);
        return data;
      } else {
        throw getErrorfromStatusCode(response.statusCode!);
      }
    } catch (e) {
      if (e is ServerFailure) {
        rethrow;
      } else {
        logger.e(e);
        throw const ServerFailure("something went wrong", 500);
      }
    }
  }

  @override
  Future<void> delete(
      {required String endpoint,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    final requestHeaders = buildHeaders(headers);
    try {
      final response = await dioClient.delete(buildUrlPath(endpoint),
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: requestHeaders));
      if (response.statusCode != StatusCode.ok) {
        throw getErrorfromStatusCode(response.statusCode!);
      }
    } catch (e) {
      if (e is ServerFailure) {
        rethrow;
      } else {
        logger.e(e);
        throw const ServerFailure("something went wrong", 500);
      }
    }
  }
}
