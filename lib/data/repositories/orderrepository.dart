import 'package:test_app/core/networkinfo/networkinfo.dart';

import '../../domain/entities/orderentity.dart';
import '../../domain/repositories/orderrepository.dart';
import '../datasources/source/order_local_ds.dart';
import '../datasources/source/order_remote_ds.dart';


class OrderRepositoryImp implements OrderRepository {
  OrderRepositoryImp(
      {required this.orderLocalDataSource,
      required this.orderRemoteDataSource,
      required this.networkInfo});
  OrderLocalDataSource orderLocalDataSource;
  OrderRemoteDataSource orderRemoteDataSource;
  NetworkInfo networkInfo;
  @override
  Future<void> addOrder(OrderEntity order) async {
    final id = await orderRemoteDataSource.addOrder(order);
    final orderEntity = order.copyWith(id: id);
    await orderLocalDataSource.addOrder(orderEntity);
  }

  @override
  Future<void> deleteOrdersByClient(String clientId) async {
    await orderRemoteDataSource.deleteOrdersByClient(clientId);
    await orderLocalDataSource.deleteOrdersByClient(clientId);
  }

  @override
  Future<List<OrderEntity>> getAllOrders() async {
    if (await networkInfo.isConnected) {
      return await orderRemoteDataSource.getAllOrders();
    } else {
      return await orderLocalDataSource.getAllOrders();
    }
  }

  @override
  Future<OrderEntity> getOrder(String orderId) async {
    if (await networkInfo.isConnected) {
      return await orderRemoteDataSource.getOrder(orderId);
    } else {
      return await orderLocalDataSource.getOrder(orderId);
    }
  }

  @override
  Future<List<OrderEntity>> getOrdersByClient(String clientId) async {
    if (await networkInfo.isConnected) {
      return await orderRemoteDataSource.getOrdersByClient(clientId);
    } else {
      return await orderLocalDataSource.getOrdersByClient(clientId);
    }
  }

  @override
  Future<void> removeOrder(String orderId) async {
    await orderRemoteDataSource.removeOrder(orderId);
    await orderLocalDataSource.removeOrder(orderId);
  }

  @override
  Future<void> updateOrder(OrderEntity order) async {
    await orderRemoteDataSource.updateOrder(order);
    await orderLocalDataSource.updateOrder(order);
  }
}
