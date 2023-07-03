import 'package:test_app/features/order/data/models/client.dart';
import 'package:test_app/features/order/domain/entities/cliententity.dart';

extension ClientModelMapper on ClientEntity {
  toClientModel() {
    return ClientModel(
        balance: this.balance,
        createdAt: this.createdAt,
        firstname: this.firstname,
        id: this.id,
        lastname: this.lastname,
        phonenumber: this.phonenumber);
  }
}
