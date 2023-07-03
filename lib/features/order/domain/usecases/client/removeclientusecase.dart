import 'package:test_app/core/usecases/usecase.dart';
import 'package:test_app/features/order/domain/repositories/clientrepository.dart';

   class RemoveClientUseCase implements UseCase<Future<void>, String> {
  RemoveClientUseCase(this._clientRepository);
  ClientRepository _clientRepository;
  
  call(String clientId) async {
    await _clientRepository.removeClient(clientId);
  }

}
