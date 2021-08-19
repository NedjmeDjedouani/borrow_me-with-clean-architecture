import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_app/models/client.dart';
import 'package:test_app/utils/dbhelper.dart';
import 'package:test_app/models/product.dart';
import 'package:test_app/utils/utils.dart';

import '../models/order.dart';

class Ordercontroller extends GetxController {
  var totalprice = 0.0.obs;
  List<Order> listoforders = <Order>[].obs;
  DbHelper dbhelper = DbHelper();
  Client selectedclient;
  String inputordername, inputprice, inputquantity;
  final GlobalKey<FormState> globalformkey = GlobalKey<FormState>();
  TextEditingController orderinputtextcontroller = TextEditingController();
  @override
  onInit() {
    selectedclient = Get.arguments;
    if (selectedclient != null) {
      getlistoforders(selectedclient).then((value) {
        listoforders.assignAll(value);
        totalprice.value = calculatetotalprice();
      });
    }
    super.onInit();
  }

  static String ordervalidator(String value) =>
      (value == null) ? "give a valid product or a price for the order" : null;

  addtototalprice(Order order) {
    totalprice = totalprice + order.price * order.quantity;
  }

  subtractfromtotalprice(Order order) {
    totalprice = totalprice - order.price * order.quantity;
  }

  String quantityvalidator(String value) =>
      Utils.isNumeric(value) ? null : "give a valid number";

  onChangeordername(String value) {
    if (value != null) {
      if (Utils.isNumeric(value)) {
        inputprice = value;
        inputordername = "Unknown";
      } else
        inputordername = value;
    }
  }

  Future<List<Order>> getlistoforders(Client client) async {
    List<Order> orderslist = [];
    await dbhelper.searchorderslist(client).then((value) {
      if (value.isNotEmpty) {
        for (int i = 0; i < value.length; i++) {
          orderslist.add(Order.frommap(value[i]));
        }
      }
    });
    return orderslist;
  }

  saveorderitem(Client client, Order order) async {
    await dbhelper.createorderitem(client, order).then((value) {
      listoforders.add(order);
      addtototalprice(order);
    });
  }

  removeorderitem(Order order, Client client) {
    dbhelper.deleteorder(order, client).then((value) {
      listoforders.remove(order);
      subtractfromtotalprice(order);
    });
  }

  double calculatetotalprice() {
    var totalprice = 0.0;
    listoforders.forEach((element) {
      totalprice = totalprice + element.price * element.quantity;
    });
    return totalprice;
  }
}
