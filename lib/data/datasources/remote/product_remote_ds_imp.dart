import 'package:test_app/core/api/apiconsumer.dart';
import 'package:test_app/core/api/endpoints.dart';
import 'package:test_app/core/utils/extansions/productentitymapperextension.dart';
import '../../../domain/entities/productentity.dart';
import '../../models/product.dart';
import '../source/product_remote_ds.dart';

class ProductRemoteDataSourceImp implements ProductRemoteDataSource {
  ProductRemoteDataSourceImp(this._apiConsumer);

  final ApiConsumer _apiConsumer;

  @override
  Future<String> addProduct(ProductEntity productEntity) async {
    return await _apiConsumer.post(
        endpoint: EndPoints.products,
        data: productEntity.toProductModel().toMap());
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final data =
        await _apiConsumer.get(endpoint: EndPoints.products) as List<dynamic>;
    final List<ProductModel> productModelList = [];
    for (var element in data) {
      productModelList.add(ProductModel.fromMap(element));
    }
    return productModelList;
  }

  @override
  Future<ProductModel> getProduct(String productId) async {
    final data = await _apiConsumer.get(endpoint: EndPoints.products);
    return ProductModel.fromMap(data);
  }

  @override
  Future<void> removeProduct(String productId) async {
    await _apiConsumer.delete(endpoint: "${EndPoints.products}/$productId");
  }

  @override
  Future<void> updateProduct(ProductEntity productEntity) async {
    await _apiConsumer.patch(
        endpoint: "${EndPoints.products}/${productEntity.id!}",
        data: productEntity.toProductModel().toMap());
  }
}
