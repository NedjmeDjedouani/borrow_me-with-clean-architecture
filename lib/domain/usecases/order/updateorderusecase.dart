
import '../../../../../core/usecases/usecase.dart';
import '../../entities/orderentity.dart';
import '../../repositories/orderrepository.dart';

class UpdateOrderUseCase implements UseCase<Future<void>, OrderEntity> {
  UpdateOrderUseCase(this._orderRepository);
  final OrderRepository _orderRepository;

  @override
  Future<void> call(OrderEntity order) async {
    await _orderRepository.updateOrder(order);
  }
}