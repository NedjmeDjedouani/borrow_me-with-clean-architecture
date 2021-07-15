import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_app/utils/dbhelper.dart';
import 'client.dart';

class Clientscontroller extends GetxController {
  String inputclientfirstname,
      inputclientlastname,
      inputclientbalance,
      inputphonenumber;
  DbHelper dbHelper = DbHelper();
  GlobalKey<FormState> globalkeyform = GlobalKey<FormState>();
  List<Client> listofclients = <Client>[].obs;
  onInit() {
    getallclients();
    super.onInit();
 }


  static String namevalidator(String name) => name.length > 40 ?'more than 40 characters' : null;


  static String barcodevalidator(String name) => name.length > 15 ? 'more than 15 characters' : null;


  static String phonevalidator(String phonenumber) {
    final String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    final RegExp regExp = RegExp(pattern);
    return  phonenumber.isNotEmpty && regExp.hasMatch(phonenumber) ? null :"phone number is not valid";

  }

  getallclients() {
    dbHelper
        .getallclientslist()
        .then((value) => listofclients.assignAll(value));
  }

  addclient(Client client) {
    dbHelper.createclient(client);
    getallclients();
  }

  removeclient(Client client) {
    dbHelper.removeclient(client).then((nrows) {
      if (nrows > 0) {
        if (listofclients.remove(client)) {
          getallclients();
        }
      }
    });
  }

  editclient(Client client) {
    int idx = listofclients.indexWhere((element) => element.id == client.id);
    listofclients[idx] = client;
    dbHelper.updateclient(client);
  }
}
