
import '../../domain/entities/cliententity.dart';

class ClientKeys {
  static const balance = "balance";
  static const createdAt = "created_at";
  static const lastName = "last_name";
  static const id = "id";
  static const phoneNumber = "phone_number";
  static const firstName = "first_name";
}

class ClientModel extends ClientEntity {
  const ClientModel(
      {String? firstname,
      String? id,
      String? lastname,
      String? phonenumber,
      double? balance,
      DateTime? createdAt})
      : super(
            phonenumber: phonenumber,
            balance: balance,
            createdAt: createdAt,
            firstname: firstname,
            id: id,
            lastname: lastname);

  factory ClientModel.frommap(Map<String, dynamic> map) {
    return ClientModel(
        balance: double.parse(map[ClientKeys.balance].toString()),
        createdAt: DateTime.parse(map[ClientKeys.createdAt]),
        firstname: map[ClientKeys.firstName],
        lastname: map[ClientKeys.lastName],
        id: map[ClientKeys.id].toString(),
        phonenumber: map[ClientKeys.phoneNumber]);
  }

  Map<String, dynamic> toMap() => {
        ClientKeys.id: id,
        ClientKeys.balance: balance,
        ClientKeys.firstName: firstname,
        ClientKeys.lastName: lastname,
        ClientKeys.phoneNumber: phonenumber,
        ClientKeys.createdAt: createdAt?.millisecondsSinceEpoch,
      };
}
