import 'package:test_app/core/api/apiconsumer.dart';
import 'package:test_app/core/api/endpoints.dart';
import 'package:test_app/features/order/data/models/client.dart';
import 'package:test_app/core/utils/extansions/cliententitymapperextension.dart';

import '../../../domain/entities/cliententity.dart';
import '../source/client_remote_datasource.dart';

class ClientRemoteDataSourceImp implements ClientRemoteDataSource {
  ClientRemoteDataSourceImp(this.apiConsumer);
  ApiConsumer apiConsumer;
  @override
  Future<String> addClient(ClientEntity client) async {
    //toClientModel() is an extension
    final data = await apiConsumer.post(
        endpoint: EndPoints.clients, data: client.toClientModel());
    return data as String;
  }

  @override
  Future<List<ClientModel>> getAllClients() async {
    final data =
        await apiConsumer.get(endpoint: EndPoints.clients) as List<dynamic>;
    final List<ClientModel> clientModelList = [];
    data.forEach((element) {
      clientModelList.add(ClientModel.frommap(element));
    });
    return clientModelList;
  }

  @override
  Future<ClientModel> getClient(String clientId) async {
    final data =
        await apiConsumer.get(endpoint: EndPoints.clients + "/" + clientId);
    return ClientModel.frommap(data);
  }

  @override
  Future<void> removeClient(String clientId) async {
    await apiConsumer.delete(endpoint: EndPoints.clients + "/" + clientId);
  }

  @override
  Future<void> updateClient(ClientEntity client) async {
    await apiConsumer.patch(
        endpoint: EndPoints.clients + "/" + client.id!,
        data: client.toClientModel());
  }
}
