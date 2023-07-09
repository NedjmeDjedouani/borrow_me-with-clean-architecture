import 'package:get/get.dart';
import 'package:test_app/core/usecases/usecase.dart';

import '../../domain/entities/cliententity.dart';
import '../../domain/usecases/client/addclientusecase.dart';
import '../../domain/usecases/client/getallclientusecase.dart';
import '../../domain/usecases/client/removeclientusecase.dart';
import '../../domain/usecases/client/updateclientusecase.dart';
import 'statecontroller.dart';

class Clientscontroller extends StateController {
  final AddClientUseCase _addClientUseCase = Get.find<AddClientUseCase>();
  final GetAllClientUseCase _getAllClientUseCase =
      Get.find<GetAllClientUseCase>();
  final UpdateClientUseCase _updateClientUseCase =
      Get.find<UpdateClientUseCase>();
  final RemoveClientUseCase _removeClientUseCase =
      Get.find<RemoveClientUseCase>();
  var listofclients = <ClientEntity>[].obs;

  @override
  onInit() {
    getallclients();

    super.onInit();
  }

  void getallclients() async {
    listofclients.clear();

    excute(() async {
      listofclients.addAll(await _getAllClientUseCase(NoParams()));
    });
  }

  void addclient(ClientEntity client) async {
    excute(() async {
      await _addClientUseCase(client);
      listofclients.add(client);
    });
  }

  void removeclient(ClientEntity client) async {
    excute(() async {
      await _removeClientUseCase(client.id!);
      listofclients.remove(client);
    });
  }

  void editclient(ClientEntity client) async {
    excute(() async {
      await _updateClientUseCase(client);
      int idx = listofclients.indexWhere((element) => element.id == client.id);
      listofclients[idx] = client;
    });
  }
}
