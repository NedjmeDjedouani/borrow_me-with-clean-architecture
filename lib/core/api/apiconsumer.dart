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
  Future<dynamic> patch(
      {required String endpoint,
     required Map<String, dynamic> data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers});
  Future<dynamic> delete(
      {required String endpoint,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers});
}

Map<String, dynamic> buildHeaders(Map<String, dynamic>? headers) {
  if (headers == null) {
    return {CONTENTTYPE: APPLICATIONJSON};
  } else if (headers.containsKey(CONTENTTYPE))
    return headers;
  else {
    return {...headers, CONTENTTYPE: APPLICATIONJSON};
  }
}

String buildUrlPath(String endpoint) {
  return p.join(BASEURL, endpoint);
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
    if (response.statusCode == StatusCode.ok) {
      final data = jsonDecode(response.data);
      return data;
    } else {
      throw getErrorfromStatusCode(response.statusCode!);
    }
  }

  @override
  Future<dynamic> patch(
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
      if (response.statusCode == StatusCode.ok) {
        final data = jsonDecode(response.data);
        return data;
      } else {
        throw getErrorfromStatusCode(response.statusCode!);
      }
    } catch (e) {
      if (e is ServerFailure) {
        rethrow;
      } else {
        logger.e(e);
        throw ServerFailure("something went wrong", 500);
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
      if (response.statusCode == StatusCode.ok) {
        final data = jsonDecode(response.data);
        return data;
      } else {
        throw getErrorfromStatusCode(response.statusCode!);
      }
    } catch (e) {
      if (e is ServerFailure) {
        rethrow;
      } else {
        logger.e(e);
        throw ServerFailure("something went wrong", 500);
      }
    }
  }

  @override
  Future<dynamic> delete(
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
      if (response.statusCode == StatusCode.ok) {
        final data = jsonDecode(response.data);
        return data;
      } else {
        throw getErrorfromStatusCode(response.statusCode!);
      }
    } catch (e) {
      if (e is ServerFailure) {
        rethrow;
      } else {
        logger.e(e);
        throw ServerFailure("something went wrong", 500);
      }
    }
  }
}
