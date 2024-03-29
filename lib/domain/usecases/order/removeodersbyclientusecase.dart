import 'package:test_app/core/usecases/usecase.dart';

import '../../repositories/orderrepository.dart';

class RemoveOrdersByClientUseCase
    implements UseCase<Future<void>, String> {
  RemoveOrdersByClientUseCase(this._orderRepository);
  final OrderRepository _orderRepository;
  @override
  Future<void> call(String clientId) async {
     await _orderRepository.deleteOrdersByClient(clientId);
  }
}
