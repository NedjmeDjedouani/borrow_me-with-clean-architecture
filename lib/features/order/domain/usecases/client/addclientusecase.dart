import 'package:test_app/features/order/domain/entities/cliententity.dart';
import 'package:test_app/features/order/domain/repositories/clientrepository.dart';

import '../../../../../core/usecases/usecase.dart';

class AddClientUseCase implements UseCase<Future<void>, ClientEntity> {
  AddClientUseCase(this._clientRepository);

  ClientRepository _clientRepository;

  @override
  Future<void> call(ClientEntity client) async {
    await _clientRepository.addClient(client);
  }
}
