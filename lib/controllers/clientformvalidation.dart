import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/features/order/domain/entities/cliententity.dart';
import 'package:test_app/utils/utils.dart';
import 'clientcontroller.dart';

class ClientFormValidation extends GetxController {
  Clientscontroller c = Get.find();
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
      inputlastnamecontroller.text = selectedclient!.lastname!;
      inputphonenumbercontroller.text = selectedclient!.phonenumber!;
      inputbalancecontroller.text = selectedclient!.balance.toString();
    }
  }

  @override
  onInit() {
    initializeinputcontrollers();
    super.onInit();
  }

  static String? namevalidator(String? name) {
    if (name == null) return "name is not valid";
    if (name.isNotEmpty) {
      return name.length > 40 ? 'more than 40 characters' : null;
    } else {
      return "this field is empty";
    }
  }

  static String? balancevalidator(String? name) {
    if (name == null) return "number is not valid";
    if (!Utils.isNumeric(name)) {
      return 'this field should be a number';
    } else if (name.length > 15) {
      return 'this number should not exceed 15 digits';
    } else
      return null;
  }

  static String? phonevalidator(String? phonenumber) {
    final String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    final RegExp regExp = RegExp(pattern);
    if (phonenumber == null) return "phonenumber is not valid";
    if (phonenumber.isEmpty) {
      return null;
    } else {
      return regExp.hasMatch(phonenumber) ? null : "phone number is not valid";
    }
  }

  void isclientformvalid() {
    if (globalkeyform.currentState!.validate()) {
      globalkeyform.currentState!.save();
      if (selectedclient == null) {
        ClientEntity client = ClientEntity(firstname: inputfirstname, lastname: inputlastname,phonenumber:  inputphonenumber,
           balance:  double.tryParse(inputbalance));
        c.addclient(client);
      } else {
        c.editclient(ClientEntity(
          id:   selectedclient!.id,
          firstname:   inputfirstname,
         lastname:    inputlastname,
          phonenumber:   inputphonenumber,
           balance:  double.tryParse(inputbalance)!,
        ));
      }
      Get.back();
    }
  }
}
