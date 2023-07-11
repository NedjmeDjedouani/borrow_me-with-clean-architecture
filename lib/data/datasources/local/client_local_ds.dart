import 'package:drift/drift.dart';
import 'package:test_app/core/cache/db.dart';
import 'package:test_app/core/cache/mappers/clientmapper.dart';
import '../../../domain/entities/cliententity.dart';
import '../../models/client.dart';
import '../source/client_local_datasource.dart';

class ClientCache {
  ClientCache(this.localDatabase);
  LocalDatabase localDatabase;
  Future<int> addClient(ClientEntity client) async {
    return await localDatabase.into(localDatabase.clientLocalModel).insert(
        ClientLocalModelCompanion.insert(
            remoteId: client.id!,
            phoneNumber: client.phonenumber == null
                ? const Value.absent()
                : Value(client.phonenumber),
            createdAt: client.createdAt == null
                ? const Value.absent()
                : Value(client.createdAt),
            lastName: client.lastname == null
                ? const Value.absent()
                : Value(client.lastname),
            firstName: client.firstname!,
            balance: client.balance!));
  }

  Future<List<Client>> getAllClients() async {
    return await localDatabase.select(localDatabase.clientLocalModel).get();
  }

  Future<Client> getClient(String clientId) async {
    return await (localDatabase.select(localDatabase.clientLocalModel)
          ..where(
            (tbl) => tbl.remoteId.equals(clientId),
          ))
        .getSingle();
  }

  Future<int> removeClient(String clientId) async {
    return await (localDatabase.delete(localDatabase.clientLocalModel)
          ..where(
            (tbl) => tbl.remoteId.equals(clientId),
          ))
        .go();
  }

  Future<int> updateClient(ClientEntity client) async {
    return await (localDatabase.update(localDatabase.clientLocalModel)
          ..where(
            (tbl) => tbl.remoteId.equals(client.id!),
          ))
        .write(ClientLocalModelCompanion(
            balance: client.balance == null
                ? const Value.absent()
                : Value(client.balance!),
            firstName: client.firstname == null
                ? const Value.absent()
                : Value(client.firstname!),
            lastName: client.lastname == null
                ? const Value.absent()
                : Value(client.lastname),
            phoneNumber: client.phonenumber == null
                ? const Value.absent()
                : Value(client.phonenumber)));
  }
}

class ClientLocalDatatSourceImp implements ClientLocalDataSource {
  ClientLocalDatatSourceImp(this.localDatabase);
  ClientCache localDatabase;
  final ClientEntityMapper _clientEntityMapper = ClientEntityMapper();
  @override
  addClient(ClientEntity client) async {
    final id = await localDatabase.addClient(client);
    return id.toString();
  }

  @override
  Future<List<ClientModel>> getAllClients() async {
    final listofClients = await localDatabase.getAllClients();
    List<ClientModel> listofClientsModels = [];
    for (var element in listofClients) {
      listofClientsModels.add(_clientEntityMapper.cachedToMap(element));
    }
    return listofClientsModels;
  }

  @override
  getClient(String clientId) async {
    final clientModel = await localDatabase.getClient(clientId);
    return _clientEntityMapper.cachedToMap(clientModel);
  }

  @override
  removeClient(String clientId) async {
    await localDatabase.removeClient(clientId);
  }

  @override
  updateClient(ClientEntity client) async {
    await localDatabase.updateClient(client);
  }
}
