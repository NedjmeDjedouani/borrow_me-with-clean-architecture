import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:test_app/core/usecases/usecase.dart';
import 'package:test_app/presentation/controllers/statecontroller.dart';

import '../../domain/entities/productentity.dart';
import '../../domain/usecases/product/addproductusecase.dart';
import '../../domain/usecases/product/getallproductsusecase.dart';
import '../../domain/usecases/product/removeproductusecase.dart';
import '../../domain/usecases/product/searchproductusecase.dart';


class ProductsController extends StateController {
  List<ProductEntity> suggestions = [];
  RxList<ProductEntity> listofproducts = <ProductEntity>[].obs;
  Rx<bool> showsearchedproduct = false.obs;
  ProductEntity? searchedproduct;
  final GetAllProductsUseCase _getAllProductsUseCase = Get.find();
  final SearchProductUseCase _searchProductUseCase = Get.find();
  final AddProductUseCase _addProductUseCase = Get.find();
  final RemoveProductUseCase _removeProductUseCase = Get.find();

  Future<void> getallproducts() async {
    excute(() async {
      listofproducts.value = await _getAllProductsUseCase(NoParams());
    });
  }

  Future<void> addproduct(ProductEntity product) async {
    excute(() async {
      await _addProductUseCase(product);
      listofproducts.add(product);
    });
  }

  Future<void> removeproduct(ProductEntity product) async {
    excute(() async {
      await _removeProductUseCase(product.id!);
      listofproducts.remove(product);
    });
  }

  Future<String> getbarcodewithcam() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ffffff", "CANCEL", true, ScanMode.BARCODE);
    return barcodeScanRes;
  }

  Future<List<ProductEntity>> searchProduct(String v) async {
    suggestions.clear();
    if (v.isNotEmpty) {
      return excute(() async {
        suggestions.addAll(await _searchProductUseCase(v));
        return suggestions;
      }) as Future<List<ProductEntity>>;
    }
    return [];
  }

  Future<void> editproduct(ProductEntity product) async {
    excute(() async {
      await editproduct(product);
      int idx =
          listofproducts.indexWhere((element) => element.id == product.id);
      listofproducts[idx] = product;
    });
  }

  bool isProductexist(String barcode) {
    return searchProductWithbarcode(barcode) == null ? false : true;
  }

  ProductEntity? searchProductWithbarcode(String barcode) {
    try {
      ProductEntity searchedproduct =
          listofproducts.firstWhere((element) => barcode == element.barcode);
      return searchedproduct;
    } catch (e) {
      return null;
    }
  }
}
