import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_app/core/cache/db.dart';
import 'package:test_app/data/datasources/local/client_local_ds.dart';
import 'package:test_app/data/models/client.dart';

import '../../../fixtures/fixturereader.dart';
import 'client_local_ds_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ClientCache>()])
void main() {
  final MockClientCache mockClientCache = MockClientCache();

  final ClientLocalDatatSourceImp clientLocalDataSource =
      ClientLocalDatatSourceImp(mockClientCache);
  final clientModel =
      ClientModel.frommap(jsonDecode(fixture('client/client.json')));
  final List<ClientModel> clientsList = [];
  List<dynamic> listOfData =
      jsonDecode(fixture('client/client_list.json'))['data'];
  for (var data in listOfData) {
    clientsList.add(ClientModel.frommap(data));
  }
  test('should get client ', () async {
// arrange
    when(mockClientCache.getClient("1")).thenAnswer((realInvocation) async =>
        Client(
            firstName: clientModel.firstname!,
            remoteId: clientModel.id!,
            balance: clientModel.balance!,
            createdAt: clientModel.createdAt,
            lastName: clientModel.lastname,
            phoneNumber: clientModel.phonenumber));

// act
    final client = await clientLocalDataSource.getClient('1');
/*     final expected = ClientModel(
        firstname: "ahmed",
        id: "1",
        balance: 0,
        createdAt: DateTime.parse('2020-03-05'),
        lastname: "jamal",
        phonenumber: "06458451234"); */
// assert
    expect(client, clientModel);
  });

  test('should add client', () async {
// arrange
    when(mockClientCache.addClient(clientModel))
        .thenAnswer((realInvocation) async => 1);

// act
    final id = await clientLocalDataSource.addClient(clientModel);
// assert
    const expected = '1';

    expect(id, expected);
  });

  test('should update client ', () async {
// arrange
    when(mockClientCache.updateClient(clientModel))
        .thenAnswer((realInvocation) async => 1);
// act
    final Future<void> future = clientLocalDataSource.updateClient(clientModel);
// assert
    expect(future, completes);
  });

  test('should delete client ', () {
// arrange
    when(mockClientCache.removeClient('1'))
        .thenAnswer((realInvocation) async => 1);

// act
    final future = clientLocalDataSource.removeClient('1');

// assert
    expect(future, completes);
  });
  test('should get all client ', () async {
// arrange
    when(mockClientCache.getAllClients()).thenAnswer((realInvocation) async {
      final List<Client> clients = [];
      for (var client in clientsList) {
        clients.add(Client(
            firstName: client.firstname!,
            remoteId: client.id!,
            createdAt: client.createdAt,
            lastName: client.lastname,
            phoneNumber: client.phonenumber,
            balance: client.balance!));
      }
      return clients;
    });
// act
    final call = await clientLocalDataSource.getAllClients();

// assert
    expect(call, clientsList);
  });
}
