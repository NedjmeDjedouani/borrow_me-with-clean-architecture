import 'package:drift/drift.dart';
import 'package:test_app/core/cache/db.dart';
import 'package:test_app/core/cache/mappers/clientmapper.dart';
import 'package:test_app/features/order/domain/entities/cliententity.dart';
import '../../models/client.dart';
import '../source/client_local_datasource.dart';

class ClientLocalDatatSourceImp implements ClientLocalDataSource {
  ClientLocalDatatSourceImp(this.localDatabase);
  LocalDatabase localDatabase ;
  final ClientEntityMapper _clientEntityMapper=ClientEntityMapper();
  @override
  addClient(ClientEntity client) async {
    final id = await localDatabase.into(localDatabase.clientLocalModel).insert(
        ClientLocalModelCompanion.insert(remoteId: client.id!,
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
    return id.toString();
  }

  @override
  Future<List<ClientModel>> getAllClients() async {
    final listofClients =
        await localDatabase.select(localDatabase.clientLocalModel).get();
    List<ClientModel> listofClientsModels = [];
    for (var element in listofClients) {
      listofClientsModels.add(_clientEntityMapper.cachedToMap(element));
    }
    return listofClientsModels;
  }

  @override
  getClient(String clientId) async {
    final clientModel =
        await (localDatabase.select(localDatabase.clientLocalModel)
              ..where(
                (tbl) => tbl.remoteId.equals(clientId),
              ))
            .getSingle();
    return _clientEntityMapper.cachedToMap(clientModel);
  }

  @override
  removeClient(String clientId) async {
    await (localDatabase.delete(localDatabase.clientLocalModel)
          ..where(
            (tbl) => tbl.remoteId.equals(clientId),
          ))
        .go();
  }

  @override
  updateClient(ClientEntity client) async {
    await (localDatabase.update(localDatabase.clientLocalModel)
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
