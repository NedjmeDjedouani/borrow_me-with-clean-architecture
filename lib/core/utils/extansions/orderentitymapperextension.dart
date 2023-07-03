import 'package:test_app/features/order/data/models/order.dart';
import 'package:test_app/features/order/domain/entities/orderentity.dart';

extension OrderModelMapper on OrderEntity {
  OrderModel toOrderModel() {
    return OrderModel(
        clientId: this.clientId,
        createdAt: this.createdAt,
        id: this.id,
        name: this.name,
        price: this.price,
        quantity: this.quantity);
  }
}
