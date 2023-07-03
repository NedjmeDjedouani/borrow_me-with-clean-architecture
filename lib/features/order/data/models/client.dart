import 'package:test_app/features/order/domain/entities/cliententity.dart';

class ClientKeys {
  static final balance = "balance";
  static final createdAt = "created_at";
  static final lastName = "last_name";
  static final id = "id";
  static final phoneNumber = "phone_number";
  static final firstName = "first_name";
}

class ClientModel extends ClientEntity {
  ClientModel(
      {String? firstname,
      String? id,
      String? lastname,
      String? phonenumber,
      double? balance,
      DateTime? createdAt})
      : super(
            balance: balance,
            createdAt: createdAt,
            firstname: firstname,
            id: id,
            lastname: lastname);

  factory ClientModel.frommap(Map<String, dynamic> map) {
    return ClientModel(
        balance: map[ClientKeys.balance],
        createdAt: DateTime.fromMillisecondsSinceEpoch(map[ClientKeys.createdAt]),
        firstname: map[ClientKeys.firstName],
        lastname: map[ClientKeys.lastName],
        id: map[ClientKeys.id],
        phonenumber: map[ClientKeys.phoneNumber]);
  }

  Map<String, dynamic> toMap() => {
        ClientKeys.id: this.id,
        ClientKeys.balance: this.balance,
        ClientKeys.firstName: this.firstname,
        ClientKeys.lastName: this.lastname,
        ClientKeys.phoneNumber: this.phonenumber,
        ClientKeys.createdAt: this.createdAt?.millisecondsSinceEpoch,
      };
}
