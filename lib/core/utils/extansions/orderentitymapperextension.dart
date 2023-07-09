

import '../../../data/models/order.dart';
import '../../../domain/entities/orderentity.dart';

extension OrderModelMapper on OrderEntity {
  OrderModel toOrderModel() {
    return OrderModel(
        clientId: clientId,
        createdAt: createdAt,
        id: id,
        name: name,
        price: price,
        quantity: quantity);
  }
}
