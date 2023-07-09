

import '../../../../../core/usecases/usecase.dart';
import '../../entities/orderentity.dart';
import '../../repositories/orderrepository.dart';

class AddOrderUseCase implements UseCase<Future<void>, OrderEntity> {
  AddOrderUseCase(this._orderRepository);
  final OrderRepository _orderRepository;

  @override
  Future<void> call(OrderEntity order) async {
    await _orderRepository.addOrder(order);
  }
}
