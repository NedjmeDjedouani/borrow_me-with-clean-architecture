import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:test_app/core/usecases/usecase.dart';
import 'package:test_app/features/order/domain/entities/productentity.dart';
import 'package:test_app/features/order/domain/usecases/product/addproductusecase.dart';
import 'package:test_app/features/order/domain/usecases/product/getallproductsusecase.dart';
import 'package:test_app/features/order/domain/usecases/product/removeproductusecase.dart';
import 'package:test_app/features/order/domain/usecases/product/searchproductusecase.dart';

class ProductsController extends GetxController {
  List<ProductEntity> suggestions = [];
  RxList<ProductEntity> listofproducts = <ProductEntity>[].obs;
  Rx<bool> showsearchedproduct = false.obs;
  ProductEntity? searchedproduct;
  RxBool isLoading = false.obs;
  RxString error = "".obs;
  GetAllProductsUseCase _getAllProductsUseCase = Get.find();
  SearchProductUseCase _searchProductUseCase = Get.find();
  AddProductUseCase _addProductUseCase = Get.find();
  RemoveProductUseCase _removeProductUseCase = Get.find();

  @override
  onInit() {
    getallproducts();
    super.onInit();
  }

  Future<void> getallproducts() async {
    try {
      isLoading.value = true;
      listofproducts.value = await _getAllProductsUseCase(NoParams());
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addproduct(ProductEntity product) async {
    try {
      isLoading.value = true;
      await _addProductUseCase(product);
      listofproducts.add(product);
      isLoading.value = false;
    } catch (e) {
    } finally {}
  }

  Future<void> removeproduct(ProductEntity product) async {
    try {
      isLoading.value = true;
      await _removeProductUseCase(product.id!);
      listofproducts.remove(product);
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> getbarcodewithcam() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ffffff", "CANCEL", true, ScanMode.BARCODE);
    return barcodeScanRes;
  }

  Future<List<ProductEntity>> searchProduct(String v) async {
    try {
      isLoading.value = true;
      suggestions.clear();
      if (v.isNotEmpty) {
        suggestions.addAll(await _searchProductUseCase(v));
        return suggestions;
      }
            return [];

    } catch (e) {
      
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> editproduct(ProductEntity product) async {
    try {
      isLoading.value = true;
      await editproduct(product);
      int idx =
          listofproducts.indexWhere((element) => element.id == product.id);
      listofproducts[idx] = product;
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
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
