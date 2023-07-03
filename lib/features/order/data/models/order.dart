import 'package:test_app/features/order/domain/entities/orderentity.dart';

class OrderKeys {
  static final createdAt = "createdAt";
  static final name = "name";
  static final price = "price";
  static final quantity = "quantity";
  static final id = "id";
  static final clientId = "clientId";
}

class OrderModel extends OrderEntity {
  OrderModel(
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
        price: map[OrderKeys.price],
        quantity: map[OrderKeys.quantity],
        clientId: map[OrderKeys.clientId],
        id: map[OrderKeys.id],
        createdAt: DateTime.fromMillisecondsSinceEpoch(map[ OrderKeys.createdAt]));
  }
  Map<String, dynamic> toMap() => {
        OrderKeys.id: this.id,
        OrderKeys.name: this.name,
        OrderKeys.price: this.price,
        OrderKeys.quantity: this.quantity,
        OrderKeys.clientId: this.clientId,
        OrderKeys.createdAt: this.createdAt?.millisecondsSinceEpoch,
      };
}
