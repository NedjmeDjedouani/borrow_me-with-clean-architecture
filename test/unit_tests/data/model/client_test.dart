import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/data/models/client.dart';

import '../../../fixtures/fixturereader.dart';

void main() {
  final ClientModel clientModel = ClientModel(
      id: "3",
      firstname: "ahmed",
      lastname: "ali",
      balance: 0,
      phonenumber: null,
      createdAt: DateTime.parse("2020-06-06 00:00:00.000Z"));

  test(" should return a map", () {
    final client = ClientModel(
        balance: 5,
        createdAt: DateTime.parse("2012-45-13"),
        firstname: "jamal",
        id: "3",
        lastname: "hakim",
        phonenumber: "0645874213");

    final expectedMap = {
      ClientKeys.balance: 5.0,
      ClientKeys.createdAt: DateTime.parse("2012-45-13"),
      ClientKeys.firstName: "jamal",
      ClientKeys.lastName: "hakim",
      ClientKeys.id: "3",
      ClientKeys.phoneNumber: "0645874213"
    };

    expect(client.toMap(), expectedMap);
  });

  test('should return a model', () {
    final clientMap = jsonDecode(fixture("client/client.json"));
    final client = ClientModel.frommap(clientMap);
    expect(client, isA<ClientModel>());
    expect(client, clientModel);
  });
}
