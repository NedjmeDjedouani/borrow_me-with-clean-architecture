
import '../entities/orderentity.dart';

abstract class OrderRepository {
  Future<List<OrderEntity>> getAllOrders();
  Future<OrderEntity> getOrder(String orderId);
  Future<void> addOrder(OrderEntity order);
  Future<void> updateOrder(OrderEntity order);
  Future<void> removeOrder(String orderId);
  Future<void> deleteOrdersByClient( String clientId);
  Future<List<OrderEntity>> getOrdersByClient(String clientId);

}
