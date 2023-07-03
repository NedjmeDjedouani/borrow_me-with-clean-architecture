import '../../domain/entities/cliententity.dart';

abstract class ClientRepository {
  Future<List<ClientEntity>> getAllClients();
  Future<ClientEntity> getClient(String clientId);
  Future<void> addClient(ClientEntity client);
    Future<void> updateClient(ClientEntity client);
    Future<void> removeClient(String clientId);

}
