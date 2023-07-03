import 'package:test_app/core/usecases/usecase.dart';
import 'package:test_app/features/order/domain/entities/orderentity.dart';
import 'package:test_app/features/order/domain/repositories/orderrepository.dart';

class GetOrdersByClientUseCase
    implements UseCase<Future<List<OrderEntity>>, String> {
  GetOrdersByClientUseCase(this._orderRepository);
  OrderRepository _orderRepository;

  Future<List<OrderEntity>> call(String clientId) async {
  return  await _orderRepository.getOrdersByClient(clientId);
  }
}
