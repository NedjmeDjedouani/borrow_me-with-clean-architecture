import 'package:test_app/features/order/data/models/order.dart';

import '../../../domain/entities/orderentity.dart';

abstract class OrderLocalDataSource {
 Future <String> addOrder(OrderEntity order);
 Future <void> removeOrder(String orderId);
Future <OrderModel>  getOrder(String orderId);
 Future <void> updateOrder(OrderEntity order);
Future <List<OrderModel>> getAllOrders();
 Future <List<OrderModel>> getOrdersByClient(String clientId);
 Future <void> deleteOrdersByClient(String clientId);
}