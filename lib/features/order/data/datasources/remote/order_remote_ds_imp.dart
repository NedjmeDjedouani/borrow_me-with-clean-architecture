import 'package:test_app/core/api/apiconsumer.dart';
import 'package:test_app/core/api/endpoints.dart';
import 'package:test_app/features/order/data/models/order.dart';
import 'package:test_app/features/order/domain/entities/orderentity.dart';
import 'package:test_app/core/utils/extansions/orderentitymapperextension.dart';

import '../source/order_remote_ds.dart';

class OrderRemoteDataSourceImp implements OrderRemoteDataSource {
  OrderRemoteDataSourceImp(this._apiConsumer);

  ApiConsumer _apiConsumer;

  @override
  Future<String> addOrder(OrderEntity order) async {
    final data = await _apiConsumer.post(
        endpoint: EndPoints.orders, data: order.toOrderModel().toMap());
    return data;
  }

  @override
  Future<void> deleteOrdersByClient(String clientId) async {
    await _apiConsumer.delete(
        endpoint: EndPoints.orders,
        queryParameters: {OrderKeys.clientId: clientId});
  }

  @override
  Future<List<OrderModel>> getAllOrders() async {
    final data =
        await _apiConsumer.get(endpoint: EndPoints.orders) as List<dynamic>;
    final List<OrderModel> ordersList = [];
    data.forEach((element) {
      ordersList.add(OrderModel.frommap(element));
    });
    return ordersList;
  }

  @override
  Future<OrderModel> getOrder(String orderId) async {
    final data =
        await _apiConsumer.get(endpoint: EndPoints.orders + "/" + orderId);
    return OrderModel.frommap(data);
  }

  @override
  Future<List<OrderModel>> getOrdersByClient(String clientId) async {
    final data = await _apiConsumer.get(
        endpoint: EndPoints.orders,
        queryParameters: {OrderKeys.clientId: clientId}) as List<dynamic>;
    final List<OrderModel> listOfOrders = [];
    data.forEach((element) {
      listOfOrders.add(OrderModel.frommap(element));
    });
    return listOfOrders;
  }

  @override
  Future<void> removeOrder(String orderId) async {
   
        await _apiConsumer.delete(endpoint: EndPoints.orders + "/" + orderId);
  }

  @override
  Future<void> updateOrder(OrderEntity order) async {
           await _apiConsumer.patch(endpoint: EndPoints.orders + "/" + order.id!,data: order.toOrderModel().toMap());

  }
}
