import '../../../domain/entities/cliententity.dart';
import '../../models/client.dart';

abstract class ClientRemoteDataSource {
  Future<String> addClient(ClientEntity client);
  Future<void> removeClient(String clientId);
  Future<ClientModel> getClient(String clientId);
  Future<void> updateClient(ClientEntity client);
  Future<List<ClientModel>> getAllClients();
}
