
import 'package:test_app/features/order/domain/entities/orderentity.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/orderrepository.dart';

class UpdateOrderUseCase implements UseCase<Future<void>, OrderEntity> {
  UpdateOrderUseCase(this._orderRepository);
  final OrderRepository _orderRepository;

  @override
  Future<void> call(OrderEntity order) async {
    await _orderRepository.updateOrder(order);
  }
}