import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/controllers/statecontroller.dart';
import 'package:test_app/features/order/domain/entities/cliententity.dart';
import 'package:test_app/features/order/domain/usecases/client/addclientusecase.dart';
import 'package:test_app/features/order/domain/usecases/client/updateclientusecase.dart';

class ClientFormValidation extends StateController {
  final AddClientUseCase _addClientUseCase = Get.find();
  final UpdateClientUseCase _updateClientUseCase = Get.find();

  GlobalKey<FormState> globalkeyform = GlobalKey<FormState>();
  late String inputfirstname, inputlastname, inputbalance, inputphonenumber;
  late TextEditingController inputfirstnamecontroller,
      inputlastnamecontroller,
      inputbalancecontroller,
      inputphonenumbercontroller;
  ClientEntity? selectedclient;

  initializeinputcontrollers() {
    selectedclient = Get.arguments;
    inputfirstnamecontroller = TextEditingController();
    inputbalancecontroller = TextEditingController();
    inputphonenumbercontroller = TextEditingController();
    inputlastnamecontroller = TextEditingController();
    if (selectedclient != null) {
      inputfirstnamecontroller.text = selectedclient!.firstname!;
      inputlastnamecontroller.text = selectedclient!.lastname ?? "";
      inputphonenumbercontroller.text = selectedclient!.phonenumber ?? "";
      inputbalancecontroller.text = selectedclient!.balance.toString();
    }
  }

  @override
  onInit() {
    initializeinputcontrollers();
    super.onInit();
  }

  void isclientformvalid() {
    if (globalkeyform.currentState!.validate()) {
      globalkeyform.currentState!.save();
      if (selectedclient == null) {
        ClientEntity client = ClientEntity(
            firstname: inputfirstname,
            lastname: inputlastname,
            phonenumber: inputphonenumber,
            balance: double.tryParse(inputbalance));
        excute(() async {
          await _addClientUseCase(client);
        });
      } else {
        excute(() async {
          final updated = ClientEntity(
            id: selectedclient!.id,
            firstname: inputfirstname,
            lastname: inputlastname,
            phonenumber: inputphonenumber,
            balance: double.tryParse(inputbalance)!,
          );
          await _updateClientUseCase(updated);
          selectedclient = updated;
          Get.back();
        });
      }
    }
  }
}
