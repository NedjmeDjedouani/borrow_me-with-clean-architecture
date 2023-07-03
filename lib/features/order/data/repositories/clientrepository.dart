import '../../../../core/networkinfo/networkinfo.dart';
import '../../domain/entities/cliententity.dart';
import '../../domain/repositories/clientrepository.dart';
import '../datasources/source/client_local_datasource.dart';
import '../datasources/source/client_remote_datasource.dart';
import '../models/client.dart';

class ClientRepositoryImp implements ClientRepository {
  ClientRepositoryImp(
      {required this.clientLocalDataSource,
      required this.clientremoteDataSource,
      required this.networkInfo,
      });
  ClientLocalDataSource clientLocalDataSource;
  ClientRemoteDataSource clientremoteDataSource;
  NetworkInfo networkInfo;
  @override
  Future<void> addClient(ClientEntity client) async {
    final id = await clientremoteDataSource.addClient(client);
    client = client.copyWith(id: id);
    await clientLocalDataSource.addClient(client);
  }

  @override
  Future<List<ClientEntity>> getAllClients() async {
    List<ClientEntity> clients;
    if (await (networkInfo.isConnected)) {
      clients = await clientremoteDataSource.getAllClients();
    } else {
      clients = await clientLocalDataSource.getAllClients();
    }
    return clients;
  }

  @override
  Future<ClientEntity> getClient(String clientId) async {
    ClientModel clientModel;
    if (await (networkInfo.isConnected)) {
      clientModel = await clientremoteDataSource.getClient(clientId);
    }
    clientModel = await clientLocalDataSource.getClient(clientId);
    return clientModel;
  }

  @override
  Future<void> removeClient(String clientId) async {
    await clientremoteDataSource.removeClient(clientId);
    await clientLocalDataSource.removeClient(clientId);
  }

  @override
  Future<void> updateClient(ClientEntity client) async {
    await clientremoteDataSource.updateClient(client);
    await clientLocalDataSource.updateClient(client);
  }
}
