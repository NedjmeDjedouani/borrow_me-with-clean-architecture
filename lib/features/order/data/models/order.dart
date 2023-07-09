import 'package:test_app/features/order/domain/entities/orderentity.dart';

class OrderKeys {
  static const createdAt = "createdAt";
  static const name = "name";
  static const price = "price";
  static const quantity = "quantity";
  static const id = "id";
  static const clientId = "clientId";
}

class OrderModel extends OrderEntity {
  const OrderModel(
      {String? clientId,
      DateTime? createdAt,
      String? name,
      String? id,
      int? quantity,
      double? price})
      : super(
            clientId: clientId,
            createdAt: createdAt,
            id: id,
            name: name,
            price: price,
            quantity: quantity);

  factory OrderModel.frommap(Map<String, dynamic> map) {
    return OrderModel(
        name: map[OrderKeys.name],
        price: double.parse(map[OrderKeys.price].toString()) ,
        quantity: map[OrderKeys.quantity],
        clientId: map[OrderKeys.clientId],
        id: map[OrderKeys.id].toString(),
        createdAt: DateTime.parse(map[ OrderKeys.createdAt]));
  }
  Map<String, dynamic> toMap() => {
        OrderKeys.id: id,
        OrderKeys.name: name,
        OrderKeys.price: price,
        OrderKeys.quantity: quantity,
        OrderKeys.clientId: clientId,
        OrderKeys.createdAt: createdAt?.millisecondsSinceEpoch,
      };
}
