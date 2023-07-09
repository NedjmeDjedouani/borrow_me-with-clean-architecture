import '../../../domain/entities/productentity.dart';
import '../../models/product.dart';

abstract class ProductLocalDataSource {
  Future<String> addProduct(ProductEntity productEntity);
  Future<void> removeProduct(String productId);
  Future<ProductModel> getProduct(String productId);
  Future<void> updateProduct(ProductEntity productEntity);
  Future<List<ProductModel>> getAllProducts();
}