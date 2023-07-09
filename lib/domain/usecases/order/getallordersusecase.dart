import 'package:test_app/core/usecases/usecase.dart';
import '../../entities/orderentity.dart';
import '../../repositories/orderrepository.dart';

class GetAllOrdersUseCase
    implements UseCase<Future<List<OrderEntity>>, NoParams> {
  GetAllOrdersUseCase(this._orderRepository);
  final OrderRepository _orderRepository;

  @override
  Future<List<OrderEntity>> call(NoParams params) async {
    return await _orderRepository.getAllOrders();
  }
}
