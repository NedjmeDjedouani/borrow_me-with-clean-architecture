import 'package:drift/drift.dart';
import 'package:test_app/core/cache/db.dart';
import 'package:test_app/core/cache/mappers/productmapper.dart';
import 'package:test_app/features/order/data/models/product.dart';
import 'package:test_app/features/order/domain/entities/productentity.dart';

import '../source/product_local_ds.dart';

class ProductLocalDataSourceImp implements ProductLocalDataSource {
  ProductLocalDataSourceImp(this.localDatabase);
  LocalDatabase localDatabase;
  ProductEntityMapper _productEntityMapper=ProductEntityMapper();
  @override
  addProduct(ProductEntity product) async {
    final id = await localDatabase.into(localDatabase.productLocalModel).insert(
        ProductLocalModelCompanion.insert(remoteId: product.id!,
            name: product.productname!,
            barcode: product.barcode!,
            price: product.price!,
            createdAt: product.createdAt!));
    return id.toString();
  }

  @override
  Future<ProductModel> getProduct(String productId) async {
    final product = await (localDatabase.select(localDatabase.productLocalModel)
          ..where((tbl) => tbl.remoteId.equals(productId)))
        .getSingle();
    return _productEntityMapper.cachedToMap(product);
  }

  @override
  removeProduct(String productId) async {
    await (localDatabase.delete(localDatabase.productLocalModel)
          ..where((tbl) => tbl.remoteId.equals((productId))))
        .go();
  }

  @override
  updateProduct(ProductEntity product) async {
    await (localDatabase.update(localDatabase.productLocalModel)
          ..where((tbl) => tbl.remoteId.equals(product.id!)))
        .write(ProductLocalModelCompanion(
            name: product.productname == null
                ? Value.absent()
                : Value(product.productname!),
            price:
                product.price == null ? Value.absent() : Value(product.price!),
            barcode: product.barcode == null
                ? Value.absent()
                : Value(product.barcode!),
            createdAt: product.createdAt == null
                ? Value.absent()
                : Value(product.createdAt!)));
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final products =
        await localDatabase.select(localDatabase.productLocalModel).get();
    final List<ProductModel> productsModelsList = [];
    products.forEach((element) {
      productsModelsList.add(_productEntityMapper.cachedToMap(element));
    });
    return productsModelsList;
  }
}
