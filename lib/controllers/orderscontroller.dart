import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_app/features/order/domain/entities/cliententity.dart';
import 'package:test_app/features/order/domain/entities/orderentity.dart';
import 'package:test_app/features/order/domain/usecases/order/addorderusecase.dart';
import 'package:test_app/features/order/domain/usecases/order/getordersbyclientusecase.dart';
import 'package:test_app/features/order/domain/usecases/order/removeorderusecase.dart';
import 'package:test_app/utils/utils.dart';


class Ordercontroller extends GetxController {
  AddOrderUseCase _addOrderUseCase = Get.find();
  RemoveOrderUseCase _removeOrderUseCase = Get.find();
  GetOrdersByClientUseCase _getOrdersByClientUseCase = Get.find();
  var totalprice = 0.0.obs;
  var listoforders = <OrderEntity>[].obs;
  RxBool isLoading = false.obs;
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
    } else
      inputordername = value;
  }

  Future<void> getlistoforders(ClientEntity client) async {
    try {
      isLoading.value = true;
      listoforders.value = await _getOrdersByClientUseCase(client.id!);
        totalprice.value = calculatetotalprice();
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }

  saveorderitem(OrderEntity order) async {
    try {
      isLoading.value = true;
      if (order.clientId != null) {
        await _addOrderUseCase(order);
        listoforders.add(order);
        addtototalprice(order);
      }
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }

  removeorderitem(OrderEntity order) async {
    try {
      isLoading.value = true;
      await _removeOrderUseCase(order.id!);
      listoforders.remove(order);
      subtractfromtotalprice(order);
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }

  double calculatetotalprice() {
    var totalprice = 0.0;
    listoforders.forEach((element) {
      totalprice = totalprice + element.price! * element.quantity!;
    });
    return totalprice;
  }
}
