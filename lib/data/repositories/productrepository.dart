import 'package:test_app/core/networkinfo/networkinfo.dart';
import '../../domain/entities/productentity.dart';
import '../../domain/repositories/productrepository.dart';
import '../datasources/source/product_local_ds.dart';
import '../datasources/source/product_remote_ds.dart';

class ProductRepositoryImp implements ProductRepository {
  ProductRepositoryImp(
      {required this.productLocalDataSource,
      required this.productRemoteDataSource,
      required this.networkInfo});

  ProductLocalDataSource productLocalDataSource;
  ProductRemoteDataSource productRemoteDataSource;
  NetworkInfo networkInfo;

  @override
  Future<void> addProduct(ProductEntity productEntity) async {
    final id = await productRemoteDataSource.addProduct(productEntity);
    final product = productEntity.copyWith(id: id);
    await productRemoteDataSource.addProduct(product);
  }

  @override
  Future<List<ProductEntity>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      return await productRemoteDataSource.getAllProducts();
    } else {
      return await productLocalDataSource.getAllProducts();
    }
  }

  @override
  Future<ProductEntity> getProduct(String productId) async {
    if (await networkInfo.isConnected) {
      return await productRemoteDataSource.getProduct(productId);
    } else {
      return await productLocalDataSource.getProduct(productId);
    }
  }

  @override
  Future<void> removeProduct(String productId) async {
    await productRemoteDataSource.removeProduct(productId);
    await productLocalDataSource.removeProduct(productId);
  }

  @override
  Future<List<ProductEntity>> searchProduct(String name) async {
    if (await networkInfo.isConnected) {
    } else {

    }
    throw UnimplementedError();
  }

  @override
  Future<void> updateProduct(ProductEntity productEntity) async {
    await productRemoteDataSource.updateProduct(productEntity);
    await productLocalDataSource.updateProduct(productEntity);
  }
}
