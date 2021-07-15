import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:test_app/utils/dbhelper.dart';
import 'package:test_app/models/product.dart';
import 'package:test_app/utils/utils.dart';

class ProductsController extends GetxController {
  List<Product> suggestions = [];
  String inputproductname, inputproductbarcode, inputproductprice;
  RxList<Product> listofproducts = <Product>[].obs;
  final GlobalKey<FormState> globalformkey = GlobalKey<FormState>();
  TextEditingController barcodecontroller=TextEditingController(),
      productnamecontroller=TextEditingController(),
      pricecontroller=TextEditingController();
  DbHelper dbHelper = DbHelper();
  Product selectedproduct;
  @override
  onInit() {
   getallproducts();
   super.onInit();
  }

  String namevalidator(String name) => name.length > 40 ? 'more than 40 characters' : null;

  String barcodevalidator(String name) {
    String pattern=r'^[0-9]+$';

    return name.length > 15 ? 'more than 15 characters': null;
  }

  String pricevalidator(String price) {
    if (!Utils.isNumeric(price)) {
      return 'this field should be a number';
    } else if (price.length > 15) {
      return 'this number should not exceed 15 digits';
    }
    else return null;
  }

  getallproducts() {
    dbHelper
        .getallproductslist()
        .then((value) => listofproducts.assignAll(value));
  }

  addproduct(Product product) {
    dbHelper.createproduct(product);
    getallproducts();
  }

  removeproduct(Product product) {
    dbHelper.removeproduct(product).then((value) {
      var rows = value;
      if (rows > 0) {
        if (listofproducts.remove(product)) {
          getallproducts();
        }
      }
    });
  }

  Future<String> getbarcodewithcam() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ffffff", "CANCEL", true, ScanMode.BARCODE);
    return barcodeScanRes;
  }

  Future<List<Product>> getproducts(String v) async {
    suggestions.clear();
    if (v.isNotEmpty) {
      await dbHelper.searchproduct(v).then((value) => {
            for (int i = 0; i < value.length; i++)
              {suggestions.add(Product.frommap(value[i]))}
          });
      return suggestions;
    }
    return null;
  }

  editproduct(Product product)
  {
    dbHelper.updateproduct(product);
  }
}
