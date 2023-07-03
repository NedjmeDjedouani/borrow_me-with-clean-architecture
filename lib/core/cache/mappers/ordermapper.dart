import 'package:test_app/core/cache/db.dart';
import 'package:test_app/core/cache/entitymapper.dart';
import '../../../features/order/data/models/order.dart';


class OrderEntityMapper implements EntityMapper<OrderModel,Order> {
 
  @override
  OrderModel cachedToMap(Order order) {
    return OrderModel(
        name: order.name,
        clientId: order.clientId.toString(),
        createdAt: order.createdAt,
        id: order.remoteId.toString(),
        price: order.price,
        quantity: order.quantity);
  }
  
  @override
  Order mapToCached(OrderModel orderModel) {
     return Order(
        remoteId: orderModel.id!,
        name: orderModel.name!,
        price: orderModel.price!,
        quantity: orderModel.quantity!,
        clientId: int.parse(orderModel.clientId!),
        createdAt: orderModel.createdAt!);
  }
}
