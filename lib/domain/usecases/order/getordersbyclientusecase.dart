import 'package:test_app/core/usecases/usecase.dart';


import '../../entities/orderentity.dart';
import '../../repositories/orderrepository.dart';

class GetOrdersByClientUseCase
    implements UseCase<Future<List<OrderEntity>>, String> {
  GetOrdersByClientUseCase(this._orderRepository);
  final OrderRepository _orderRepository;

  @override
  Future<List<OrderEntity>> call(String clientId) async {
  return  await _orderRepository.getOrdersByClient(clientId);
  }
}
