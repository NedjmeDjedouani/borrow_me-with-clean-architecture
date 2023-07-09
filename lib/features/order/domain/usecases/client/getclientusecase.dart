import 'package:test_app/core/usecases/usecase.dart';
import 'package:test_app/features/order/domain/entities/cliententity.dart';
import 'package:test_app/features/order/domain/repositories/clientrepository.dart';

class GetClientUseCase implements UseCase<Future<ClientEntity>, String> {
  GetClientUseCase(this._clientRepository);
  final ClientRepository _clientRepository;

  @override
  Future<ClientEntity> call(String clientId) async {

    return await _clientRepository.getClient(clientId);
  }
}
