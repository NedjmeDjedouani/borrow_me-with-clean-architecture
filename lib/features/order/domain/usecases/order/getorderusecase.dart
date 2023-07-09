








import '../../../../../core/usecases/usecase.dart';
import '../../entities/orderentity.dart';
import '../../repositories/orderrepository.dart';

class GetOrderUseCase implements UseCase<Future<OrderEntity>, String> {
  GetOrderUseCase(this._orderRepository);
  final OrderRepository _orderRepository;

  @override
  Future<OrderEntity> call(String orderId) async {
    return await _orderRepository.getOrder(orderId);
  }
}