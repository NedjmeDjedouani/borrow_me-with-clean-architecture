import 'package:get/get.dart';
import 'package:test_app/utils/dbhelper.dart';
import '../models/client.dart';

class Clientscontroller extends GetxController {
  DbHelper dbHelper = DbHelper();
  var listofclients = <Client>[].obs;

  onInit() {
    getallclients();
    super.onInit();
  }

  void getallclients() {
    dbHelper
        .getallclientslist()
        .then((value) => listofclients.assignAll(value));
  }

  void addclient(Client client) {
    dbHelper.createclient(client);
    getallclients();
  }

  void removeclient(Client client) {
    dbHelper.removeclient(client).then((nrows) {
      if (nrows > 0) {
        if (listofclients.remove(client)) {
          getallclients();
        }
      }
    });
  }

  void editclient(Client client) {
    int idx = listofclients.indexWhere((element) => element.id == client.id);
    listofclients[idx] = client;
    dbHelper.updateclient(client);
  }
}
