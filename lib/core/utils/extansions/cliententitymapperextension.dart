import 'package:test_app/features/order/data/models/client.dart';
import 'package:test_app/features/order/domain/entities/cliententity.dart';

extension ClientModelMapper on ClientEntity {
 ClientModel toClientModel() {
    return ClientModel(
        balance: balance,
        createdAt: createdAt,
        firstname: firstname,
        id: id,
        lastname: lastname,
        phonenumber: phonenumber);
  }
}
