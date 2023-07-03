import 'package:get/get.dart';
import 'package:test_app/core/usecases/usecase.dart';
import 'package:test_app/features/order/domain/entities/cliententity.dart';
import 'package:test_app/features/order/domain/usecases/client/addclientusecase.dart';
import 'package:test_app/features/order/domain/usecases/client/getallclientusecase.dart';
import 'package:test_app/features/order/domain/usecases/client/removeclientusecase.dart';
import 'package:test_app/features/order/domain/usecases/client/updateclientusecase.dart';

class Clientscontroller extends GetxController {
  AddClientUseCase _addClientUseCase = Get.find<AddClientUseCase>();
  GetAllClientUseCase _getAllClientUseCase = Get.find<GetAllClientUseCase>();
  UpdateClientUseCase _updateClientUseCase = Get.find<UpdateClientUseCase>();
  RemoveClientUseCase _removeClientUseCase = Get.find<RemoveClientUseCase>();
  var listofclients = <ClientEntity>[].obs;
  var isLoading = false.obs;
  var error = "".obs;
  onInit() {
    getallclients();

    super.onInit();
  }

  void getallclients() async {
    isLoading.value = true;
    try {
      await _getAllClientUseCase(NoParams());
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }

  void addclient(ClientEntity client) async {
    await _addClientUseCase(client);
    listofclients.add(client);
  }

  void removeclient(ClientEntity client) async {
    await _removeClientUseCase(client.id!);
  }

  void editclient(ClientEntity client) async {
    try {
      isLoading.value = true;
      await _updateClientUseCase(client);
      int idx = listofclients.indexWhere((element) => element.id == client.id);
      listofclients[idx] = client;
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }
}
