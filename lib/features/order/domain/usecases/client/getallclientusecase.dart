








import '../../../../../core/usecases/usecase.dart';
import '../../entities/cliententity.dart';
import '../../repositories/clientrepository.dart';

class GetAllClientUseCase implements UseCase<Future<List<ClientEntity>>, NoParams> {
  GetAllClientUseCase(this._clientRepository);
  ClientRepository _clientRepository;

  @override
  Future<List<ClientEntity>> call(NoParams noParams) async {

    return await _clientRepository.getAllClients();
  }
}