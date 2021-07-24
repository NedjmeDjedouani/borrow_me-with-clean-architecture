import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/models/product.dart';
import 'package:test_app/models/productscontroller.dart';

import 'utils/utils.dart';

class ProductValidationForm extends GetxController {

  ProductsController pc = Get.find();

  @override
onInit()
{selectedproduct=Get.arguments;
  if (selectedproduct!=null)
    {
      barcodecontroller.text=selectedproduct.barcode;
      productnamecontroller.text=selectedproduct.productname;
      pricecontroller.text=selectedproduct.price.toString();

    }
  super.onInit();
}


  String inputproductname,
      inputproductbarcode,
      inputproductprice;

  TextEditingController barcodecontroller = TextEditingController(),
      productnamecontroller = TextEditingController(),
      pricecontroller = TextEditingController();

  final GlobalKey<FormState> globalformkey = GlobalKey<FormState>();



  Product selectedproduct;

  static String namevalidator(String name) =>
      name.length > 40 ? 'more than 40 characters' : null;

  static String barcodevalidator(String name) {
    String pattern = r'^[0-9]+$';

    return name.length > 15 ? 'more than 15 characters' : null;
  }

  static String pricevalidator(String price) {
    if (!Utils.isNumeric(price)) {
      return 'this field should be a number';
    } else if (price.length > 15) {
      return 'this number should not exceed 15 digits';
    } else
      return null;
  }




  isproductformvalid()
  {
    if (globalformkey.currentState.validate()) {
      globalformkey.currentState.save();
      if (selectedproduct == null) {
        Product p = Product(
            inputproductname,
            inputproductbarcode,
            double.parse(inputproductprice));
        pc.addproduct(p);
        Get.snackbar('item is registered', 'Info',colorText: Colors.white,);
      } else {
        pc.editproduct(Product.withid(
            selectedproduct.id,
            inputproductname,
            inputproductbarcode,
            double.tryParse(
                inputproductprice)));
        Get.back();
      }

    }
  }



}
