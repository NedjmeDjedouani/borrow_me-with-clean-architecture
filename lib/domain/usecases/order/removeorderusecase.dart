





import '../../../../../core/usecases/usecase.dart';
import '../../repositories/orderrepository.dart';

class RemoveOrderUseCase implements UseCase<Future<void>, String> {
  RemoveOrderUseCase(this._orderRepository);
  final OrderRepository _orderRepository;

  @override
  Future<void> call(String orderId) async {
    await _orderRepository.removeOrder(orderId);
  }
}