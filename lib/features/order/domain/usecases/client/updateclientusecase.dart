import 'package:test_app/core/usecases/usecase.dart';
import 'package:test_app/features/order/domain/entities/cliententity.dart';
import 'package:test_app/features/order/domain/repositories/clientrepository.dart';

class UpdateClientUseCase implements UseCase<Future<void>, ClientEntity> {
  UpdateClientUseCase(this._clientRepository);
  final ClientRepository _clientRepository;

  @override
  Future<void> call(ClientEntity client) async {
    await _clientRepository.updateClient(client);
  }
}
