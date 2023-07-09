import 'package:test_app/core/usecases/usecase.dart';

import '../../entities/cliententity.dart';
import '../../repositories/clientrepository.dart';


class GetClientUseCase implements UseCase<Future<ClientEntity>, String> {
  GetClientUseCase(this._clientRepository);
  final ClientRepository _clientRepository;

  @override
  Future<ClientEntity> call(String clientId) async {

    return await _clientRepository.getClient(clientId);
  }
}
