import 'package:test_app/features/order/domain/entities/orderentity.dart';
import 'package:test_app/features/order/domain/repositories/orderrepository.dart';

import '../../../../../core/usecases/usecase.dart';

class AddOrderUseCase implements UseCase<Future<void>, OrderEntity> {
  AddOrderUseCase(this._orderRepository);
  OrderRepository _orderRepository;

  @override
  Future<void> call(OrderEntity order) async {
    await _orderRepository.addOrder(order);
  }
}
