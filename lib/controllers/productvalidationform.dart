import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/controllers/productscontroller.dart';
import 'package:test_app/features/order/domain/entities/productentity.dart';
import 'package:test_app/features/order/domain/usecases/product/addproductusecase.dart';
import 'package:test_app/features/order/domain/usecases/product/updateproductusecase.dart';

import '../utils/utils.dart';

class ProductValidationForm extends GetxController {
  AddProductUseCase _addProductUseCase = Get.find();
  UpdateProductUseCase _updateProductUseCase = Get.find();
  ProductsController _productsController = Get.find();
  RxBool isLoading = false.obs;
  var error = "".obs;
  @override
  onInit() {
    selectedproduct = Get.arguments;
    if (selectedproduct != null) {
      barcodecontroller.text = selectedproduct!.barcode!;
      productnamecontroller.text = selectedproduct!.productname!;
      pricecontroller.text = selectedproduct!.price.toString();
    }
    super.onInit();
  }

  late String inputproductname, inputproductbarcode, inputproductprice;

  TextEditingController barcodecontroller = TextEditingController(),
      productnamecontroller = TextEditingController(),
      pricecontroller = TextEditingController();

  final GlobalKey<FormState> globalformkey = GlobalKey<FormState>();

  ProductEntity? selectedproduct;

  static String? namevalidator(String? name) {
    if (name == null) return null;
    if (name.isNotEmpty) {
      return name.length > 40 ? 'more than 40 characters' : null;
    } else
      return "this field is empty";
  }

  static String? barcodevalidator(String? name) {
/*     String pattern = r'^[0-9]+$';

 */
    if (name == null) return null;
    if (name.isNotEmpty) {
      return name.length > 15 ? 'more than 15 characters' : null;
    } else {
      return "this field is empty";
    }
  }

  static String? pricevalidator(String? price) {
    if (price == null) return null;
    if (!Utils.isNumeric(price)) {
      return 'this field should be a number';
    } else if (price.length > 15) {
      return 'this number should not exceed 15 digits';
    } else
      return null;
  }

  void clearinputcontrollers() {
    pricecontroller.clear();
    productnamecontroller.clear();
    barcodecontroller.clear();
  }

  _addProduct() async {
    ProductEntity p = ProductEntity(
        productname: inputproductname,
        barcode: inputproductbarcode,
        price: double.parse(inputproductprice),
        createdAt: DateTime.now());
    await _addProductUseCase(p);
    clearinputcontrollers();
    Get.snackbar('Info:', 'item is registered',
        colorText: Colors.white,
        isDismissible: true,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black);
  }

  _updateProduct() async {
    await _updateProductUseCase(ProductEntity(
      id: selectedproduct!.id,
      productname: inputproductname,
      barcode: inputproductbarcode,
      price: double.tryParse(inputproductprice)!,
    ));

    Get.back();
  }

  addOrUpdateProduct() async {
    try {
      if (globalformkey.currentState!.validate()) {
        globalformkey.currentState!.save();
        if (selectedproduct == null) {
          if (!_productsController.isProductexist(inputproductbarcode)) {
            isLoading.value = true;
            await _addProduct();
          } else {
            Get.snackbar('Info', 'item already exist',
                colorText: Colors.red,
                snackPosition: SnackPosition.BOTTOM,
                borderWidth: 1,
                borderColor: Colors.red,
                backgroundColor: Colors.white38);
          }
        } else {
          isLoading.value = true;
          await _updateProduct();
        }
      }
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }
}
