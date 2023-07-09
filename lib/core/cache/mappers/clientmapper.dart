import 'package:test_app/core/cache/db.dart';
import 'package:test_app/core/cache/entitymapper.dart';

import '../../../data/models/client.dart';

class ClientEntityMapper implements EntityMapper<ClientModel,Client> {
  @override
  Client mapToCached(ClientModel clientModel) {
    return Client(
        firstName: clientModel.firstname!,
        remoteId: clientModel.id!,
        balance: clientModel.balance!,
        createdAt: clientModel.createdAt,
        phoneNumber: clientModel.phonenumber,
        lastName: clientModel.lastname);
  }

   @override
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
