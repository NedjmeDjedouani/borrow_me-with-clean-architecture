// Mocks generated by Mockito 5.4.2 from annotations
// in test_app/test/unit_tests/data/datasource/client_remote_ds_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dio/dio.dart' as _i2;
import 'package:logger/logger.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:test_app/core/api/apiconsumer.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDio_0 extends _i1.SmartFake implements _i2.Dio {
  _FakeDio_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLogger_1 extends _i1.SmartFake implements _i3.Logger {
  _FakeLogger_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [DioConsumer].
///
/// See the documentation for Mockito's code generation for more information.
class MockDioConsumer extends _i1.Mock implements _i4.DioConsumer {
  @override
  _i2.Dio get dioClient => (super.noSuchMethod(
        Invocation.getter(#dioClient),
        returnValue: _FakeDio_0(
          this,
          Invocation.getter(#dioClient),
        ),
        returnValueForMissingStub: _FakeDio_0(
          this,
          Invocation.getter(#dioClient),
        ),
      ) as _i2.Dio);
  @override
  _i3.Logger get logger => (super.noSuchMethod(
        Invocation.getter(#logger),
        returnValue: _FakeLogger_1(
          this,
          Invocation.getter(#logger),
        ),
        returnValueForMissingStub: _FakeLogger_1(
          this,
          Invocation.getter(#logger),
        ),
      ) as _i3.Logger);
  @override
  set logger(_i3.Logger? _logger) => super.noSuchMethod(
        Invocation.setter(
          #logger,
          _logger,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.Future<dynamic> get({
    required String? endpoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [],
          {
            #endpoint: endpoint,
            #queryParameters: queryParameters,
            #headers: headers,
          },
        ),
        returnValue: _i5.Future<dynamic>.value(),
        returnValueForMissingStub: _i5.Future<dynamic>.value(),
      ) as _i5.Future<dynamic>);
  @override
  _i5.Future<void> patch({
    required String? endpoint,
    required Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [],
          {
            #endpoint: endpoint,
            #data: data,
            #queryParameters: queryParameters,
            #headers: headers,
          },
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<dynamic> post({
    required String? endpoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool? formDataIsEnabled = false,
    required Map<String, dynamic>? data,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [],
          {
            #endpoint: endpoint,
            #queryParameters: queryParameters,
            #headers: headers,
            #formDataIsEnabled: formDataIsEnabled,
            #data: data,
          },
        ),
        returnValue: _i5.Future<dynamic>.value(),
        returnValueForMissingStub: _i5.Future<dynamic>.value(),
      ) as _i5.Future<dynamic>);
  @override
  _i5.Future<void> delete({
    required String? endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [],
          {
            #endpoint: endpoint,
            #data: data,
            #queryParameters: queryParameters,
            #headers: headers,
          },
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}
