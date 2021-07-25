import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:test_app/utils/dbhelper.dart';
import 'package:test_app/models/product.dart';

class ProductsController extends GetxController {
  List<Product> suggestions = [];
  RxList<Product> listofproducts = <Product>[].obs;
  DbHelper dbHelper = DbHelper();
  @override
  onInit() {
   getallproducts();
   super.onInit();
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
      if (value > 0) {
        //  int idx=listofproducts.indexWhere((element) => element.id==product.id);
        //  listofproducts.removeAt(idx);
          listofproducts.remove(product);
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
   int idx=listofproducts.indexWhere((element) => element.id==product.id);
   listofproducts[idx]=product;
    dbHelper.updateproduct(product);
  }
}
