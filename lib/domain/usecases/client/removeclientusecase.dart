import 'package:test_app/core/usecases/usecase.dart';

import '../../repositories/clientrepository.dart';

   class RemoveClientUseCase implements UseCase<Future<void>, String> {
  RemoveClientUseCase(this._clientRepository);
  final ClientRepository _clientRepository;
  
  @override
  call(String clientId) async {
    await _clientRepository.removeClient(clientId);
  }

}
