import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_app/core/api/apiconsumer.dart';
import 'package:test_app/core/api/endpoints.dart';
import 'package:test_app/data/datasources/remote/client_remote_ds_imp.dart';
import 'package:test_app/data/models/client.dart';

import '../../../fixtures/fixturereader.dart';
import 'client_remote_ds_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DioConsumer>()])
void main() {
  Logger logger = Logger();
  late MockDioConsumer dio;
  final clientModel =
      ClientModel.frommap(jsonDecode(fixture('client/client.json')));
  late ClientRemoteDataSourceImp clientRemoteDataSourceImp;

  setUp(() {
    dio = MockDioConsumer();
    clientRemoteDataSourceImp = ClientRemoteDataSourceImp(dio);
  });

  test("should return a client", () async {
    // arrange
    logger.i(fixture("client/client.json"));
    when(dio.get(endpoint: "${EndPoints.clients}/1"))
        .thenAnswer((_) async => jsonDecode(fixture('client/client.json')));
    // act

    final call = await clientRemoteDataSourceImp.getClient("1");

    // assert
    expect(call, isA<ClientModel>());
    expect(call, clientModel);
  });
}
