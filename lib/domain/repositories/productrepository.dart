
import '../entities/productentity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getAllProducts();
  Future<ProductEntity> getProduct(String productId);
  Future<void> addProduct(ProductEntity productEntity);
  Future<void> updateProduct(ProductEntity productEntity);
  Future<void> removeProduct(String productId);
  Future<List<ProductEntity>> searchProduct(String name);
}
