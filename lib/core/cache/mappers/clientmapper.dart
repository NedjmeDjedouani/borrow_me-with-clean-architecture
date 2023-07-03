import 'package:test_app/core/cache/db.dart';
import 'package:test_app/core/cache/entitymapper.dart';

import '../../../features/order/data/models/client.dart';
class ClientEntityMapper implements EntityMapper<ClientModel,Client> {
  Client mapToCached(ClientModel clientModel) {
    return Client(
        firstName: clientModel.firstname!,
        remoteId: clientModel.id!,
        balance: clientModel.balance!,
        createdAt: clientModel.createdAt,
        phoneNumber: clientModel.phonenumber,
        lastName: clientModel.lastname);
  }

   ClientModel cachedToMap(Client client) {
    return ClientModel(
        balance: client.balance,
        createdAt: client.createdAt,
        firstname: client.firstName,
        id: client.remoteId,
        lastname: client.lastName,
        phonenumber: client.phoneNumber);
  }
}
