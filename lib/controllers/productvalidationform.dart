import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/models/product.dart';
import 'package:test_app/controllers/productscontroller.dart';

import '../utils/utils.dart';

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

  static String namevalidator(String name)
  {
    if (name.isNotEmpty)
      {
        return name.length > 40 ?  'more than 40 characters' : null;
      }
    else return "this field is empty";
  }


  static String barcodevalidator(String name) {
    String pattern = r'^[0-9]+$';
    if (name.isNotEmpty)
      {
       return name.length > 15 ? 'more than 15 characters' : null;
      }
    else
      {
        return "this field is empty";
      }
  }

  static String pricevalidator(String price) {
    if (!Utils.isNumeric(price)) {
      return 'this field should be a number';
    } else if (price.length > 15) {
      return 'this number should not exceed 15 digits';
    } else
      return null;
  }

void clearinputcontrollers()
{
  pricecontroller.clear();
  productnamecontroller.clear();
  barcodecontroller.clear();
}



  isproductformvalid()
  {
    if (globalformkey.currentState.validate()) {
      globalformkey.currentState.save();
      if (selectedproduct == null) {


         if(!pc.isProductexist(inputproductbarcode))
           {
             Product p = Product(
                 inputproductname,
                 inputproductbarcode,
                 double.parse(inputproductprice),DateTime.now());
             pc.addproduct(p);
             clearinputcontrollers();
             Get.snackbar( 'Info:','item is registered',
                 colorText: Colors.white,
                 snackPosition: SnackPosition.BOTTOM,
                 backgroundColor: Colors.black);
           }
         else {
           Get.snackbar( 'Info','item already exist', colorText: Colors.red,
               snackPosition: SnackPosition.BOTTOM,
               borderWidth: 1,
               borderColor: Colors.red,
               backgroundColor: Colors.white38);
           }

      } else {
        pc.editproduct(Product.withid(
            selectedproduct.id,
            inputproductname,
            inputproductbarcode,
            double.tryParse(
                inputproductprice),DateTime.now()));
        Get.back();
      }

    }
  }



}
