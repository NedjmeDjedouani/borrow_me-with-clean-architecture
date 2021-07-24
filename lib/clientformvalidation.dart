
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/models/client.dart';

import 'clients.dart';
import 'models/clientcontroller.dart';

class ClientFormValidation extends GetxController {
  Clientscontroller c = Get.find();
  GlobalKey<FormState> globalkeyform = GlobalKey<FormState>();
  String inputfirstname,
      inputlastname,
      inputbalance,
      inputphonenumber;
  TextEditingController inputfirstnamecontroller,
      inputlastnamecontroller,
      inputbalancecontroller,
      inputphonenumbercontroller;
  Client selectedclient;

  initializeinputcontrollers() {
    selectedclient=Get.arguments;
    inputfirstnamecontroller = TextEditingController();
    inputbalancecontroller = TextEditingController();
    inputphonenumbercontroller = TextEditingController();
    inputlastnamecontroller = TextEditingController();
    if (selectedclient != null) {
      inputfirstnamecontroller.text = selectedclient.firstname;
      inputlastnamecontroller.text = selectedclient.lastname;
      inputphonenumbercontroller.text = selectedclient.phonenumber;
      inputbalancecontroller.text = selectedclient.balance.toString();
    }
  }

  @override
  onInit()
  {
    initializeinputcontrollers();
    super.onInit();
  }


  static String namevalidator(String name) =>
      name.length > 40 ? 'more than 40 characters' : null;

  static String barcodevalidator(String name) =>
      name.length > 15 ? 'more than 15 characters' : null;

  static String phonevalidator(String phonenumber) {
    final String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    final RegExp regExp = RegExp(pattern);
    return phonenumber.isNotEmpty && regExp.hasMatch(phonenumber)
        ? null
        : "phone number is not valid";
  }

  void isclientformvalid() {
    if (globalkeyform.currentState.validate()) {
      globalkeyform.currentState.save();
      if (selectedclient == null) {
        Client client = Client(inputfirstname, inputlastname,
            inputphonenumber, double.tryParse(inputbalance));
        c.addclient(client);
      } else {
        c.editclient(Client.withid(
            selectedclient.id,
            inputfirstname,
            inputlastname,
            inputphonenumber,
            double.tryParse(inputbalance)));
      }
Get.back();
    }
  }
}