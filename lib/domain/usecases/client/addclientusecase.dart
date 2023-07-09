

import '../../../../../core/usecases/usecase.dart';
import '../../entities/cliententity.dart';
import '../../repositories/clientrepository.dart';

class AddClientUseCase implements UseCase<Future<void>, ClientEntity> {
  AddClientUseCase(this._clientRepository);

  final ClientRepository _clientRepository;

  @override
  Future<void> call(ClientEntity client) async {
    await _clientRepository.addClient(client);
  }
}
