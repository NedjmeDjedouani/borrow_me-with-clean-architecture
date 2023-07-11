import 'package:test_app/core/cache/db.dart';
import 'package:test_app/core/cache/mappers/ordermapper.dart';

import '../../../domain/entities/orderentity.dart';
import '../../models/order.dart';
import '../source/order_local_ds.dart';




class OrderLocalDataSourceImp implements OrderLocalDataSource {
  OrderLocalDataSourceImp(this.localDatabase);
  LocalDatabase localDatabase;
  final OrderEntityMapper _orderEntityMapper=OrderEntityMapper();
  @override
  addOrder(OrderEntity order) async {
    final id = await localDatabase.into(localDatabase.orderLocalModel).insert(
        OrderLocalModelCompanion.insert(remoteId: order.id!,
            name: order.name!,
            price: order.price!,
            quantity: order.quantity!,
            clientId: int.parse((order.clientId!)),
            createdAt: order.createdAt!));
    return id.toString();
  }

  @override
  Future<OrderModel> getOrder(String orderId) async {
    final order = await (localDatabase.select(localDatabase.orderLocalModel)
          ..where((tbl) => tbl.remoteId.equals(orderId)))
        .getSingle();
    return _orderEntityMapper.cachedToMap(order);
  }

  @override
  removeOrder(String orderId) async {
    await (localDatabase.delete(localDatabase.orderLocalModel)
          ..where((tbl) => tbl.remoteId.equals(orderId)))
        .go();
  }

  @override
  updateOrder(OrderEntity order) async {
    await (localDatabase.update(localDatabase.orderLocalModel)
          ..where((tbl) => tbl.remoteId.equals(order.id!)))
        .write(const OrderLocalModelCompanion());
  }

  @override
  Future<List<OrderModel>> getAllOrders() async {
    final orders =
        await localDatabase.select(localDatabase.orderLocalModel).get();
    final List<OrderModel> ordersModelsList = [];
    for (var element in orders) {
      ordersModelsList.add(_orderEntityMapper.cachedToMap(element));
    }
    return ordersModelsList;
  }

  @override
  deleteOrdersByClient(String clientId) async {
    await (localDatabase.delete(localDatabase.orderLocalModel)
          ..where((tbl) => tbl.clientId.equals(int.parse(clientId))))
        .go();
  }

  @override
  Future<List<OrderModel>> getOrdersByClient(String clientId) async {
    final orders = await (localDatabase.select(localDatabase.orderLocalModel)
          ..where((tbl) => tbl.clientId.equals(int.parse(clientId))))
        .get();
    final List<OrderModel> ordersModelsList = [];
    for (var element in orders) {
      ordersModelsList.add(_orderEntityMapper.cachedToMap(element));
    }
    return ordersModelsList;
  }
}
