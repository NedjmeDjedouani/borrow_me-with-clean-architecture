import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_app/controllers/statecontroller.dart';
import 'package:test_app/features/order/domain/entities/cliententity.dart';
import 'package:test_app/features/order/domain/entities/orderentity.dart';
import 'package:test_app/features/order/domain/usecases/order/addorderusecase.dart';
import 'package:test_app/features/order/domain/usecases/order/getordersbyclientusecase.dart';
import 'package:test_app/features/order/domain/usecases/order/removeorderusecase.dart';
import 'package:test_app/utils/utils.dart';

class Ordercontroller extends StateController {
  final AddOrderUseCase _addOrderUseCase = Get.find();
  final RemoveOrderUseCase _removeOrderUseCase = Get.find();
  final GetOrdersByClientUseCase _getOrdersByClientUseCase = Get.find();
  var totalprice = 0.0.obs;
  var listoforders = <OrderEntity>[].obs;
  ClientEntity? selectedclient;
  String? inputordername, inputprice, inputquantity;
  final GlobalKey<FormState> globalformkey = GlobalKey<FormState>();
  TextEditingController orderinputtextcontroller = TextEditingController();
  @override
  onInit() {
    selectedclient = Get.arguments;
    if (selectedclient != null) {
      getlistoforders(selectedclient!);
    }
    super.onInit();
  }

  static String? ordervalidator(String? value) =>
      (value == null) ? "give a valid product or a price for the order" : null;

  addtototalprice(OrderEntity order) {
    totalprice.value = (totalprice.value + order.price! * order.quantity!);
  }

  subtractfromtotalprice(OrderEntity order) {
    totalprice.value = totalprice.value - order.price! * order.quantity!;
  }

  String? quantityvalidator(String? value) {
    if (value == null) return null;

    return Utils.isNumeric(value) ? null : "give a valid number";
  }

  onChangeordername(String value) {
    if (Utils.isNumeric(value)) {
      inputprice = value;
      inputordername = "Unknown";
    } else {
      inputordername = value;
    }
  }

  Future<void> getlistoforders(ClientEntity client) async {
    excute(() async {
      listoforders.value = await _getOrdersByClientUseCase(client.id!);
      totalprice.value = calculatetotalprice();
    });
  }

  saveorderitem(OrderEntity order) async {
    if (order.clientId != null) {
      excute(() async {
        await _addOrderUseCase(order);
        listoforders.add(order);
        addtototalprice(order);
      });
    }
  }

  removeorderitem(OrderEntity order) async {
    excute(() async {
      await _removeOrderUseCase(order.id!);
      listoforders.remove(order);
      subtractfromtotalprice(order);
    });
  }

  double calculatetotalprice() {
    var totalprice = 0.0;
    for (var element in listoforders) {
      totalprice = totalprice + element.price! * element.quantity!;
    }
    return totalprice;
  }
}
